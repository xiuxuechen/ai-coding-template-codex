# PM Driver 工作流详解

> 版本：v1.0 | 最后更新：2026-01-11

---

## 目录

1. [概念总览](#1-概念总览)
2. [架构设计](#2-架构设计)
3. [完整工作流程](#3-完整工作流程)
4. [Project PM Driver 详解](#4-project-pm-driver-详解)
5. [AI PM Driver 详解](#5-ai-pm-driver-详解)
6. [状态文件说明](#6-状态文件说明)
7. [典型使用场景](#7-典型使用场景)
8. [故障排除](#8-故障排除)
9. [最佳实践](#9-最佳实践)

---

## 1. 概念总览

### 1.1 什么是 PM Driver？

PM Driver 是一套自动化编排系统，用于管理和协调 AI 辅助的软件开发流程。它分为两个层级：

| 层级 | 名称 | 角色 | 职责 |
|------|------|------|------|
| **项目级** | Project PM Driver | Mayor（市长） | 协调多个 Feature 并行开发 |
| **功能级** | AI PM Driver | Polecat（执行者） | 执行单个 Feature 的 Phase 1-7 |

### 1.2 核心概念

```
┌─────────────────────────────────────────────────────────────────┐
│                        概念关系图                                │
└─────────────────────────────────────────────────────────────────┘

Project（项目）
    │
    ├── Foundation（基础设施）
    │   ├── MODULE_DECOMPOSITION  → 定义所有 Feature 和依赖关系
    │   ├── ROADMAP               → 定义里程碑和目标日期
    │   └── PROJECT_TRACKER       → 追踪整体进度
    │
    └── Features（功能模块）
        ├── feature-a/
        │   ├── Phase 1-7         → 开发阶段
        │   ├── Phase Gate        → 质量门禁
        │   └── AI PM State       → 编排状态
        ├── feature-b/
        └── feature-c/
```

### 1.3 关键术语

| 术语 | 说明 |
|------|------|
| **Ready Set** | 所有依赖已满足、可立即开始的 Feature 集合 |
| **Phase Gate** | 每个开发阶段的质量检查点（共 7 个） |
| **Driver State** | 编排器的运行状态（running/paused/stuck 等） |
| **Human Confirm** | 需要人工确认才能继续的模式 |
| **Full Auto** | 全自动执行，仅在卡住时暂停 |

---

## 2. 架构设计

### 2.1 系统架构

```
┌─────────────────────────────────────────────────────────────────┐
│                     Human（开发者/PM）                           │
│  • 执行初始化命令                                                │
│  • 分发 Agent 命令到多个 CLI 会话                                │
│  • 审批 Gate 检查结果                                            │
│  • 处理 stuck 状态                                               │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      前置条件（Foundation）                       │
│                                                                  │
│  执行 /init-project 命令，生成并完善以下 Foundation 文档：       │
│                                                                  │
│  规划文档（docs/_foundation/_planning/）：                       │
│  • 01_USER_JOURNEY.md      - 用户旅程地图                        │
│  • 02_ARCHITECTURE.md      - 系统架构设计                        │
│  • 03_MODULE_DECOMPOSITION.md - Feature 列表和依赖关系 ⭐        │
│  • 04_ROADMAP.md           - 里程碑和时间线 ⭐                   │
│  • 05_TECH_DECISIONS.md    - 技术决策记录                        │
│                                                                  │
│  Foundation Gate 审批：                                          │
│  • /check-gate --phase=0                                        │
│  • /approve-gate --phase=0 --role=PM                            │
│  • /approve-gate --phase=0 --role=Architect                     │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│              Project PM Driver（/project-pm）                    │
│                                                                  │
│  职责：                                                          │
│  • 从 MODULE_DECOMPOSITION 解析 Feature 列表                    │
│  • 计算 Ready Set（可执行任务集合）                              │
│  • 生成 dev agent 命令                                           │
│  • 汇总各 Feature 进度                                           │
│  • 更新里程碑完成率                                              │
│                                                                  │
│  状态文件：                                                      │
│  • docs/_foundation/PROJECT_TRACKER.yaml                        │
│  • docs/_foundation/PROJECT_PM_STATE.yaml                       │
│  • docs/_foundation/PROJECT_ACTIVITY_LOG.yaml                   │
└────────────────────────────┬────────────────────────────────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│  AI PM Driver   │ │  AI PM Driver   │ │  AI PM Driver   │
│  (feature-a)    │ │  (feature-b)    │ │  (feature-c)    │
│                 │ │                 │ │                 │
│ 职责：          │ │ 职责：          │ │ 职责：          │
│ • Phase 1-7 执行│ │ • Phase 1-7 执行│ │ • Phase 1-7 执行│
│ • Gate 检查     │ │ • Gate 检查     │ │ • Gate 检查     │
│ • 自动修复      │ │ • 自动修复      │ │ • 自动修复      │
│ • 状态转换      │ │ • 状态转换      │ │ • 状态转换      │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

### 2.2 目录结构

```
project-root/
├── docs/
│   ├── _foundation/                      # 项目级文档
│   │   ├── _planning/                    # 规划文档
│   │   │   ├── 01_USER_JOURNEY.md        # 用户旅程
│   │   │   ├── 02_ARCHITECTURE.md        # 架构设计
│   │   │   ├── 03_MODULE_DECOMPOSITION.md # Feature 列表 ⭐
│   │   │   ├── 04_ROADMAP.md             # 里程碑定义 ⭐
│   │   │   └── 05_TECH_DECISIONS.md      # 技术决策
│   │   │
│   │   ├── FOUNDATION_GATE_STATUS.yaml   # Phase 0 Gate 状态
│   │   ├── PROJECT_TRACKER.yaml          # 项目追踪器 ⭐
│   │   ├── PROJECT_PM_STATE.yaml         # Project PM 状态 ⭐
│   │   └── PROJECT_ACTIVITY_LOG.yaml     # 活动日志 ⭐
│   │
│   ├── feature-a/                        # Feature 目录
│   │   ├── 10_CONTEXT.md                 # 需求上下文
│   │   ├── 20_API_SPEC.md                # API 规格
│   │   ├── 30_DEMO/                      # Demo 页面
│   │   ├── 40_DESIGN.md                  # 设计文档
│   │   ├── 50_DEV_PLAN.md                # 开发计划
│   │   ├── 60_TEST_PLAN.md               # 测试计划
│   │   ├── 70_RELEASE_NOTE.md            # 发布说明
│   │   ├── 90_PROGRESS_LOG.yaml          # 进度日志 ⭐
│   │   ├── PHASE_GATE_STATUS.yaml        # Gate 状态 ⭐
│   │   └── AI_PM_ORCHESTRATION_STATE.yaml # AI PM 状态 ⭐
│   │
│   ├── feature-b/
│   └── feature-c/
```

### 2.3 数据流向

```
输入层（规划文档）
┌────────────────────────────┐
│ 03_MODULE_DECOMPOSITION.md │ ──┐
│ (Feature 列表、依赖关系)    │   │
└────────────────────────────┘   │
                                 ├──→ PROJECT_TRACKER.yaml
┌────────────────────────────┐   │
│ 04_ROADMAP.md              │ ──┘
│ (里程碑定义)               │
└────────────────────────────┘

处理层（编排命令）
┌────────────────────────────┐
│ /project-pm ready          │ ──→ Ready Set
│ /project-pm assign         │ ──→ Dev Agent 命令
│ /project-pm check          │ ──→ 进度汇总
└────────────────────────────┘
              │
              ▼
┌────────────────────────────┐
│ /ai-pm start feature-a     │ ──→ 执行 Phase 1-7
│ /ai-pm status feature-a    │ ──→ 查看状态
│ /ai-pm pause/resume/stop   │ ──→ 控制执行
└────────────────────────────┘

反馈层（状态更新）
┌────────────────────────────┐
│ 90_PROGRESS_LOG.yaml       │ ──┐
│ PHASE_GATE_STATUS.yaml     │   ├──→ /project-pm check
│ AI_PM_ORCHESTRATION_STATE  │ ──┘
└────────────────────────────┘
              │
              ▼
┌────────────────────────────┐
│ PROJECT_TRACKER.yaml       │ ──→ 更新 Feature 状态
│ PROJECT_ACTIVITY_LOG.yaml  │ ──→ 记录活动
└────────────────────────────┘
```

---

## 3. 完整工作流程

### 3.1 端到端流程图

```
┌─────────────────────────────────────────────────────────────────┐
│                     完整工作流程                                 │
└─────────────────────────────────────────────────────────────────┘

阶段 0: Foundation 准备
═══════════════════════════════════════════════════════════════════

Step 1: 初始化项目
┌──────────────────────────────────────────────────────────────────┐
│  Human> /init-project                                            │
│                                                                  │
│  创建：                                                          │
│  • docs/_foundation/_planning/ 目录结构                         │
│  • 规划文档模板                                                  │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 2: 填写规划文档
┌──────────────────────────────────────────────────────────────────┐
│  Human 填写：                                                    │
│  • 03_MODULE_DECOMPOSITION.md (定义 Feature 和依赖)             │
│  • 04_ROADMAP.md (定义里程碑和时间线)                           │
│                                                                  │
│  示例 MODULE_DECOMPOSITION：                                     │
│  | module_id | feature_name  | milestone | priority | blocked_by│
│  |-----------|---------------|-----------|----------|-----------|
│  | M001      | user-auth     | M1        | 1        | -         │
│  | M002      | user-profile  | M1        | 2        | user-auth │
│  | M003      | payment       | M2        | 1        | user-auth │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 3: Foundation Gate 检查
┌──────────────────────────────────────────────────────────────────┐
│  Human> /check-gate --phase=0                                    │
│                                                                  │
│  检查项：                                                        │
│  • 规划文档完整性                                                │
│  • Feature 列表有效性                                            │
│  • 依赖关系无循环                                                │
│                                                                  │
│  Human> /approve-gate --phase=0 --role=PM                        │
│  Human> /approve-gate --phase=0 --role=Architect                 │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 4: 初始化 Project PM
┌──────────────────────────────────────────────────────────────────┐
│  Human> /project-pm init                                         │
│                                                                  │
│  创建：                                                          │
│  • PROJECT_TRACKER.yaml                                         │
│  • PROJECT_PM_STATE.yaml                                        │
│  • PROJECT_ACTIVITY_LOG.yaml                                    │
│                                                                  │
│  计算初始 Ready Set                                              │
└──────────────────────────────────────────────────────────────────┘


阶段 1-7: Feature 开发循环
═══════════════════════════════════════════════════════════════════

Step 5: 获取 Ready Set
┌──────────────────────────────────────────────────────────────────┐
│  Human> /project-pm ready                                        │
│                                                                  │
│  输出：                                                          │
│  可立即执行：                                                    │
│  ┌─────────────────┬──────────┬──────────┐                      │
│  │ Feature         │ Milestone│ Priority │                      │
│  ├─────────────────┼──────────┼──────────┤                      │
│  │ user-auth       │ M1       │ 1        │                      │
│  └─────────────────┴──────────┴──────────┘                      │
│                                                                  │
│  被阻塞：                                                        │
│  • user-profile (blocked_by: user-auth)                         │
│  • payment (blocked_by: user-auth)                              │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 6: 创建 Feature 目录（如果不存在）
┌──────────────────────────────────────────────────────────────────┐
│  Human> /new-feature user-auth                                   │
│                                                                  │
│  创建：                                                          │
│  • docs/user-auth/ 目录                                         │
│  • 10_CONTEXT.md                                                │
│  • 90_PROGRESS_LOG.yaml                                         │
│  • PHASE_GATE_STATUS.yaml                                       │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 7: 生成 Dev Agent 命令
┌──────────────────────────────────────────────────────────────────┐
│  Human> /project-pm assign                                       │
│                                                                  │
│  输出：                                                          │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ Agent 1: user-auth                                          ││
│  ├─────────────────────────────────────────────────────────────┤│
│  │ /ai-pm start user-auth --mode=full_auto --from-phase=1      ││
│  └─────────────────────────────────────────────────────────────┘│
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 8: 执行 AI PM Driver（在独立 CLI 会话中）
┌──────────────────────────────────────────────────────────────────┐
│  [CLI Session 1]                                                 │
│  Human> /ai-pm start user-auth --mode=full_auto --from-phase=1   │
│                                                                  │
│  AI PM 自动执行：                                                │
│  • Phase 1 Kickoff → Gate 检查 → 通过 → 进入 Phase 2            │
│  • Phase 2 Spec    → Gate 检查 → 通过 → 进入 Phase 3            │
│  • Phase 3 Demo    → Gate 检查 → 通过 → 进入 Phase 4            │
│  • ...                                                          │
│  • Phase 7 Deploy  → Gate 检查 → 通过 → 完成                    │
│                                                                  │
│  [如果卡住]                                                      │
│  Human> /ai-pm status user-auth   # 查看状态                    │
│  Human> /ai-pm resume user-auth   # 恢复执行                    │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 9: 检查进度
┌──────────────────────────────────────────────────────────────────┐
│  Human> /project-pm check                                        │
│                                                                  │
│  更新 PROJECT_TRACKER：                                         │
│  • user-auth: Phase 1 → Phase 7 (COMPLETED)                     │
│                                                                  │
│  新增 Ready（依赖解除）：                                        │
│  • user-profile                                                 │
│  • payment                                                      │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 10: 继续下一轮（循环 Step 5-9）
┌──────────────────────────────────────────────────────────────────┐
│  Human> /project-pm ready                                        │
│  Human> /project-pm assign                                       │
│                                                                  │
│  生成：                                                          │
│  • Agent 2: /ai-pm start user-profile --mode=full_auto          │
│  • Agent 3: /ai-pm start payment --mode=full_auto               │
│                                                                  │
│  [并行执行多个 CLI 会话]                                         │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
Step 11: 项目完成
┌──────────────────────────────────────────────────────────────────┐
│  Human> /project-pm status                                       │
│                                                                  │
│  所有 Feature 状态为 done                                        │
│  所有 Milestone 完成率 100%                                      │
└──────────────────────────────────────────────────────────────────┘
```

### 3.2 并行开发示意图

```
时间轴 ──────────────────────────────────────────────────────────▶

Foundation
├── /init-project
├── 填写规划文档
├── /check-gate --phase=0
└── /project-pm init
     │
     ▼
Round 1: Ready Set = [user-auth]
     │
     └── CLI-1: /ai-pm start user-auth ════════════════════════╗
                                                               ║
                                                               ▼
                                              user-auth 完成 ──┘
                                                               │
Round 2: Ready Set = [user-profile, payment]                   │
     │                                                         │
     ├── CLI-2: /ai-pm start user-profile ════════════════════╗│
     │                                                        ║│
     └── CLI-3: /ai-pm start payment ═════════════════════════╬╣
                                                              ║║
                                                              ▼▼
                                    user-profile, payment 完成 ┘│
                                                                │
Round 3: Ready Set = [notification]                             │
     │                                                          │
     └── CLI-4: /ai-pm start notification ═══════════════════╗  │
                                                             ║  │
                                                             ▼  ▼
                                              所有 Feature 完成 ┘
```

---

## 4. Project PM Driver 详解

### 4.1 命令总览

| 命令 | 说明 | 前置条件 |
|------|------|----------|
| `/project-pm init` | 初始化项目追踪器 | Foundation Gate passed |
| `/project-pm status` | 查看项目整体状态 | PROJECT_TRACKER 存在 |
| `/project-pm ready` | 获取可执行任务集合 | PROJECT_TRACKER 存在 |
| `/project-pm assign` | 生成 dev agent 命令 | Ready Set 非空 |
| `/project-pm check` | 检查并更新进度 | PROJECT_TRACKER 存在 |
| `/project-pm sync` | 同步 ROADMAP 变更 | PROJECT_TRACKER 存在 |
| `/project-pm logs` | 查看活动日志 | PROJECT_ACTIVITY_LOG 存在 |

### 4.2 `/project-pm init` - 初始化

**用途**：从规划文档创建项目追踪器

**前置条件**：
1. Foundation Gate (Phase 0) 已通过
2. `03_MODULE_DECOMPOSITION.md` 已填写
3. `04_ROADMAP.md` 已定义

**执行流程**：

```
1. 检查 Foundation Gate 状态
   └── 读取 FOUNDATION_GATE_STATUS.yaml
   └── 验证 gate_state == "passed"

2. 解析 MODULE_DECOMPOSITION
   └── 提取 Feature 列表
   └── 提取依赖关系 (blocked_by)

3. 解析 ROADMAP
   └── 提取里程碑定义
   └── 提取目标日期

4. 循环依赖检测
   └── DFS 算法检测有向图环
   └── 发现循环则报错终止

5. 创建状态文件
   └── PROJECT_TRACKER.yaml
   └── PROJECT_PM_STATE.yaml
   └── PROJECT_ACTIVITY_LOG.yaml

6. 计算初始 Ready Set
   └── 无依赖的 Feature 进入 Ready Set
```

**示例输出**：

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Project PM 初始化
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

从以下文档读取配置：
  • docs/_foundation/_planning/03_MODULE_DECOMPOSITION.md
  • docs/_foundation/_planning/04_ROADMAP.md

已创建：
  ✅ docs/_foundation/PROJECT_TRACKER.yaml
  ✅ docs/_foundation/PROJECT_PM_STATE.yaml
  ✅ docs/_foundation/PROJECT_ACTIVITY_LOG.yaml

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 检测到的功能模块
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

里程碑 M1 (MVP):
  • user-auth (priority: 1)
  • user-profile (priority: 2, blocked_by: user-auth)

里程碑 M2 (Complete):
  • payment (priority: 1, blocked_by: user-auth)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 Ready Set（可立即开始）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  • user-auth

执行 /project-pm assign 生成 dev agent 命令
```

### 4.3 `/project-pm ready` - Ready Set 计算

**用途**：计算并显示可立即执行的任务集合

**计算规则**：

```python
Ready Set = {
    feature for feature in all_features
    if feature.status != "done"
    and feature.status != "blocked"
    and directory_exists(f"docs/{feature}/")
    and all(dep.status == "done" for dep in feature.blocked_by)
}
```

**示例输出**：

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 Ready Set - 可执行任务
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

计算时间: 2026-01-11T10:30:00

可立即执行（无阻塞依赖）：
┌─────────────────┬──────────┬──────────┬─────────────────────┐
│ Feature         │ Milestone│ Priority │ Status              │
├─────────────────┼──────────┼──────────┼─────────────────────┤
│ user-auth       │ M1       │ 1        │ in_progress (P4)    │
│ config-service  │ M1       │ 3        │ pending             │
└─────────────────┴──────────┴──────────┴─────────────────────┘

被阻塞（等待依赖完成）：
┌─────────────────┬──────────┬─────────────────────┐
│ Feature         │ Milestone│ Blocked By          │
├─────────────────┼──────────┼─────────────────────┤
│ user-profile    │ M1       │ user-auth           │
│ payment         │ M2       │ user-auth           │
└─────────────────┴──────────┴─────────────────────┘

执行 /project-pm assign 生成开发命令
```

### 4.4 `/project-pm assign` - 生成命令

**用途**：为 Ready Set 中的 Feature 生成 AI PM 命令

**参数**：
- `--max=N`：最多生成 N 条命令（默认 5）

**示例输出**：

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 Dev Agent 命令生成
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

基于 Ready Set，生成以下命令：

┌─────────────────────────────────────────────────────────────┐
│ Agent 1: user-auth                                          │
├─────────────────────────────────────────────────────────────┤
│ /ai-pm start user-auth --mode=full_auto --from-phase=4      │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ Agent 2: config-service                                     │
├─────────────────────────────────────────────────────────────┤
│ /ai-pm start config-service --mode=full_auto --from-phase=1 │
└─────────────────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 操作步骤
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. 打开新的 Codex CLI 终端
2. 复制上述命令执行
3. 完成后执行 /project-pm check 检查进度

⚠️ 注意：每个命令应在独立的 CLI 会话中执行
```

### 4.5 `/project-pm check` - 进度检查

**用途**：扫描各 Feature 进度，更新 PROJECT_TRACKER

**执行流程**：

```
1. 读取 PROJECT_TRACKER

2. 遍历每个 Feature
   ├── 检查目录是否存在
   ├── 读取 90_PROGRESS_LOG.yaml
   ├── 读取 PHASE_GATE_STATUS.yaml
   └── 更新 current_phase, gate_state, status

3. 重新计算 Ready Set

4. 更新统计信息

5. 记录活动日志

6. 保存 PROJECT_TRACKER
```

### 4.6 `/project-pm status` - 状态概览

**用途**：显示项目整体进度

**示例输出**：

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 项目整体状态
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

项目: my-project
更新时间: 2026-01-11T11:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏁 里程碑进度
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

M0 Foundation     ████████████████████ 100% ✅
M1 MVP            ████████████░░░░░░░░  60% 🔄 (target: 2026-02-01)
M2 Complete       ██░░░░░░░░░░░░░░░░░░  10% 🔄 (target: 2026-03-01)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 Feature 概览
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─────────────────┬────┬────┬────┬────┬────┬────┬────┬─────────┐
│ Feature         │ P1 │ P2 │ P3 │ P4 │ P5 │ P6 │ P7 │ Status  │
├─────────────────┼────┼────┼────┼────┼────┼────┼────┼─────────┤
│ user-auth       │ ✅ │ ✅ │ ✅ │ ✅ │ ✅ │ ✅ │ ✅ │ done    │
│ user-profile    │ ✅ │ 🔄 │ ⏳ │ ⏳ │ ⏳ │ ⏳ │ ⏳ │ Phase 2 │
│ payment         │ 🔄 │ ⏳ │ ⏳ │ ⏳ │ ⏳ │ ⏳ │ ⏳ │ Phase 1 │
└─────────────────┴────┴────┴────┴────┴────┴────┴────┴─────────┘

图例: ✅ done | 🔄 wip | ⏳ pending | 🔒 blocked

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 统计
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Features: 3
  ✅ Done:        1
  🔄 In Progress: 2
  ⏳ Pending:     0
  🔒 Blocked:     0

Ready Set: 2 features can proceed in parallel
```

### 4.7 `/project-pm logs` - 活动日志

**用途**：查看项目活动历史

**参数**：
- `--tail=N`：显示最近 N 条记录（默认 20）
- `--type=TYPE`：筛选活动类型

**活动类型**：
- `project_initialized` - 项目初始化
- `feature_created` - Feature 创建
- `feature_started` - Feature 开始开发
- `phase_completed` - 阶段完成
- `feature_completed` - Feature 完成
- `feature_blocked` - Feature 阻塞
- `milestone_completed` - 里程碑完成

---

## 5. AI PM Driver 详解

### 5.1 命令总览

| 命令 | 说明 | 前置状态 |
|------|------|----------|
| `start` | 启动驱动器 | `idle` 或无状态 |
| `status` | 查看状态 | 任何状态 |
| `pause` | 暂停执行 | `running` |
| `resume` | 恢复执行 | `paused` 或 `stuck` |
| `stop` | 停止执行 | 非 `idle` |
| `confirm` | 确认继续 | `waiting_human` |
| `reject` | 拒绝继续 | `waiting_human` |
| `skip` | 跳过阶段 | `stuck` |
| `logs` | 查看日志 | 任何状态 |

### 5.2 状态机

```
                                    start
                                      │
                                      ▼
                        ┌─────────────────────────┐
                        │        running          │
                        │   (自动执行 Phase Gate) │
                        └───────────┬─────────────┘
                                    │
            ┌───────────┬───────────┼───────────┬───────────┐
            │           │           │           │           │
            ▼           ▼           ▼           ▼           ▼
     ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐
     │  paused  │ │  stuck   │ │ waiting_ │ │completed │ │  failed  │
     │          │ │          │ │  human   │ │          │ │          │
     └────┬─────┘ └────┬─────┘ └────┬─────┘ └──────────┘ └────┬─────┘
          │            │            │                         │
          │   resume   │   resume   │  confirm                │ restart
          └────────────┴────────────┴─────────┐               │
                                              ▼               ▼
                                         running           idle

状态说明：
• running       - 正在自动执行 Phase Gate 检查和修复
• paused        - 人工暂停，等待 resume
• stuck         - 遇到无法自动解决的问题，需要人工干预
• waiting_human - human_confirm 模式下等待人工确认进入下一阶段
• completed     - Phase 7 Gate 通过，Feature 开发完成
• failed        - 达到最大重试次数，执行失败
• idle          - 未启动或已停止
```

### 5.3 `/ai-pm start` - 启动驱动器

**语法**：
```bash
/ai-pm start {feature} --mode={mode} [--from-phase=N]
```

**参数**：
- `feature`：功能名称（必需）
- `--mode`：运行模式（必需）
  - `full_auto`：全自动执行，仅在 stuck 时暂停
  - `human_confirm`：每个阶段通过后等待人工确认
- `--from-phase`：起始阶段（可选，默认 1）

**前置条件**：
1. Feature 目录存在：`docs/{feature}/`
2. 前置 Gate 已通过（from-phase - 1）
3. 没有正在运行的 Driver

**执行流程**：

```
1. 验证前置条件
   ├── 检查目录存在
   ├── 检查前置 Gate 状态
   └── 检查是否已有运行中的 Driver

2. 创建状态文件
   └── AI_PM_ORCHESTRATION_STATE.yaml

3. 记录活动日志
   └── 追加到 PROJECT_ACTIVITY_LOG

4. 开始编排循环
   └── 执行 /check-gate {feature} --phase={from_phase}
```

**示例**：
```bash
# 全自动模式，从 Phase 1 开始
/ai-pm start user-auth --mode=full_auto --from-phase=1

# 人工确认模式，从 Phase 3 继续
/ai-pm start user-auth --mode=human_confirm --from-phase=3
```

### 5.4 运行模式对比

| 特性 | full_auto | human_confirm |
|------|-----------|---------------|
| Gate 检查 | 自动执行 | 自动执行 |
| 自动修复 | 自动执行 | 自动执行 |
| 阶段切换 | 自动进入下一阶段 | 等待人工确认 |
| stuck 处理 | 暂停等待人工 | 暂停等待人工 |
| 适用场景 | 成熟流程、标准开发 | 关键功能、需要审核 |

### 5.5 `/ai-pm pause/resume/stop` - 控制命令

**pause**：暂停执行
```bash
/ai-pm pause user-auth

# 输出
⏸️ 已暂停
功能：user-auth
暂停时间：2026-01-11T16:45:00

使用 /ai-pm resume user-auth 恢复
```

**resume**：恢复执行
```bash
/ai-pm resume user-auth

# 输出
▶️ 已恢复
功能：user-auth
前一状态：paused
恢复时间：2026-01-11T16:50:00

继续执行编排...
```

**stop**：停止执行
```bash
/ai-pm stop user-auth --confirm

# 输出
⏹️ 已停止
功能：user-auth
停止时间：2026-01-11T16:55:00

Driver 已停止。使用以下命令重新启动：
/ai-pm start user-auth --mode=full_auto
```

### 5.6 `/ai-pm status` - 状态查询

**语法**：
```bash
/ai-pm status {feature}
```

**输出内容**：
1. 基本信息（feature, mode, status）
2. 当前进度（phase, gate_state）
3. 编排计数器（fix_attempts, no_progress）
4. 时间线（started_at, last_progress_at）
5. 最后决策（action, decision, reason）

### 5.7 编排循环逻辑

```
┌─────────────────────────────────────────────────────────────────┐
│                        编排循环                                  │
└─────────────────────────────────────────────────────────────────┘

开始
  │
  ▼
┌─────────────────┐
│ 实时查询状态     │  ← 从 90_PROGRESS_LOG 和 PHASE_GATE_STATUS 读取
│ current_phase   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐     Yes
│ current_phase   │ ────────▶ 完成，生成报告
│ > target_phase? │
└────────┬────────┘
         │ No
         ▼
┌─────────────────┐     触发
│ 检查熔断条件     │ ────────▶ 进入 stuck 状态
│                 │           等待人工干预
└────────┬────────┘
         │ 未触发
         ▼
┌─────────────────┐
│ 执行 Gate 检查   │  ← 委托给 /check-gate
│                 │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
 通过       失败
    │         │
    ▼         ▼
┌─────────┐ ┌─────────────────┐
│ mode?   │ │ 可自动修复?     │
└────┬────┘ └────────┬────────┘
     │               │
┌────┴────┐    ┌─────┴─────┐
│         │    │           │
full_auto human │           │
     │    _confirm         │
     │         │     Yes   │   No
     ▼         ▼      │    │
┌─────────┐ ┌─────────┐    │
│执行     │ │等待     │    │
│next-phase│ │confirm │    │
└─────────┘ └─────────┘    │
     │         │           │
     └────┬────┘           │
          │                ▼
          │         ┌─────────────┐
          │         │ 执行自动修复 │
          │         │ 增加计数器   │
          │         └──────┬──────┘
          │                │
          └────────────────┘
                   │
                   ▼
              循环继续
```

### 5.8 熔断机制

| 熔断条件 | 阈值 | 触发后动作 |
|----------|------|------------|
| 单问题修复次数 | 2 | 进入 stuck |
| 单阶段修复次数 | 5 | 进入 stuck |
| 总修复次数 | 10 | 进入 stuck |
| 连续无进展 | 3 | 进入 stuck |
| 总超时时间 | 480 分钟 | 进入 failed |

---

## 6. 状态文件说明

### 6.1 PROJECT_TRACKER.yaml

**位置**：`docs/_foundation/PROJECT_TRACKER.yaml`

**结构**：
```yaml
meta:
  project: "my-project"
  schema_version: "1.0"
  created_at: "2026-01-11T10:00:00"
  last_updated: "2026-01-11T12:00:00"

milestones:
  M0:
    name: "Foundation"
    status: completed
    completion_rate: 100
  M1:
    name: "MVP"
    target_date: "2026-02-01"
    status: in_progress
    features: ["user-auth", "user-profile"]
    completion_rate: 50

features:
  "user-auth":
    id: "M001"
    name: "用户认证"
    milestone: "M1"
    priority: 1
    status: done
    current_phase: 7
    gate_state: passed
    blocked_by: []
    blocks: ["user-profile", "payment"]

ready_set:
  computed_at: "2026-01-11T12:00:00"
  features: ["user-profile", "payment"]

stats:
  total_features: 3
  by_status:
    done: 1
    in_progress: 2
```

### 6.2 AI_PM_ORCHESTRATION_STATE.yaml

**位置**：`docs/{feature}/AI_PM_ORCHESTRATION_STATE.yaml`

**结构**：
```yaml
meta:
  feature: "user-auth"
  schema_version: "1.1"
  created_at: "2026-01-11T10:00:00"

intent:
  mode: "full_auto"
  start_phase: 1
  target_phase: 7
  allow_auto_fix: true
  allow_skip: false

policy:
  auto_fix:
    max_attempts_per_issue: 2
    max_attempts_per_phase: 5
    max_total_attempts: 10
  circuit_breaker:
    stuck_timeout_minutes: 30
    total_timeout_minutes: 480
    no_progress_threshold: 3

runtime:
  status: "running"
  last_action: "start"
  last_decision: "continue"
  last_decision_reason: "Driver 启动"
  last_decision_at: "2026-01-11T10:00:00"

counters:
  total_fix_attempts: 0
  current_phase_fix_attempts: 0
  consecutive_no_progress: 0

timeline:
  started_at: "2026-01-11T10:00:00"
  last_progress_at: "2026-01-11T10:00:00"
```

### 6.3 PROJECT_ACTIVITY_LOG.yaml

**位置**：`docs/_foundation/PROJECT_ACTIVITY_LOG.yaml`

**结构**：
```yaml
meta:
  project: "my-project"
  schema_version: "1.0"

activities:
  - timestamp: "2026-01-11T12:00:00"
    type: "feature_completed"
    feature: "user-auth"
    description: "user-auth 功能开发完成"
    by: "/ai-pm"

  - timestamp: "2026-01-11T10:00:00"
    type: "feature_started"
    feature: "user-auth"
    by: "/ai-pm start"

summary:
  total_activities: 2
  features_completed: 1
  last_activity_at: "2026-01-11T12:00:00"
```

---

## 7. 典型使用场景

### 7.1 场景一：新项目启动

```bash
# 1. 初始化项目
/init-project

# 2. 填写规划文档
# 编辑 docs/_foundation/_planning/03_MODULE_DECOMPOSITION.md
# 编辑 docs/_foundation/_planning/04_ROADMAP.md

# 3. Foundation Gate 检查和审批
/check-gate --phase=0
/approve-gate --phase=0 --role=PM
/approve-gate --phase=0 --role=Architect

# 4. 初始化项目追踪
/project-pm init

# 5. 创建第一个 Feature
/new-feature user-auth

# 6. 启动开发
/ai-pm start user-auth --mode=full_auto --from-phase=1
```

### 7.2 场景二：多 Feature 并行开发

```bash
# 主控制台
Human> /project-pm ready
# 输出：Ready Set = [feature-a, feature-b, feature-c]

Human> /project-pm assign
# 输出：
# Agent 1: /ai-pm start feature-a ...
# Agent 2: /ai-pm start feature-b ...
# Agent 3: /ai-pm start feature-c ...

# 打开 3 个独立 CLI 会话
# CLI-1
Human> /ai-pm start feature-a --mode=full_auto

# CLI-2
Human> /ai-pm start feature-b --mode=full_auto

# CLI-3
Human> /ai-pm start feature-c --mode=full_auto

# 主控制台定期检查进度
Human> /project-pm check
Human> /project-pm status
```

### 7.3 场景三：处理 stuck 状态

```bash
# 发现 AI PM 进入 stuck 状态
Human> /ai-pm status user-auth
# 状态：🔴 stuck
# 原因：Phase 5 Gate 检查失败，无法自动修复

# 选项 1：手动修复后恢复
# 修复代码问题
Human> /ai-pm resume user-auth

# 选项 2：跳过当前阶段（需要审批）
Human> /ai-pm skip user-auth --reason="技术债务，后续处理" --approver="@pm"

# 选项 3：停止执行
Human> /ai-pm stop user-auth --confirm
```

### 7.4 场景四：关键功能的人工确认模式

```bash
# 对于支付等关键功能，使用 human_confirm 模式
Human> /ai-pm start payment --mode=human_confirm --from-phase=1

# AI PM 完成 Phase 1 Gate 后暂停
# 状态：🟡 waiting_human
# 等待确认进入 Phase 2

# 审核后确认
Human> /ai-pm confirm payment

# 继续执行，下一个 Phase 完成后再次暂停...
```

### 7.5 场景五：查看项目进度

```bash
# 查看整体状态
Human> /project-pm status

# 查看活动日志
Human> /project-pm logs --tail=10

# 查看特定类型活动
Human> /project-pm logs --type=feature_completed

# 查看特定 Feature 状态
Human> /ai-pm status user-auth

# 查看 AI PM 日志
Human> /ai-pm logs user-auth --tail=20
```

---

## 8. 故障排除

### 8.1 常见问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| `/project-pm init` 失败 | Foundation Gate 未通过 | 执行 `/check-gate --phase=0` 和 `/approve-gate` |
| Ready Set 为空 | 所有 Feature 被阻塞或已完成 | 检查依赖关系，执行 `/project-pm check` |
| `/ai-pm start` 失败 | 前置 Gate 未通过 | 检查前一阶段的 Gate 状态 |
| AI PM 进入 stuck | 达到熔断阈值 | 手动修复问题后执行 `/ai-pm resume` |
| Feature 状态不更新 | 目录不存在或文件缺失 | 执行 `/new-feature` 创建目录 |

### 8.2 诊断命令

```bash
# 检查 Feature 目录结构
ls docs/{feature}/

# 检查 Gate 状态
cat docs/{feature}/PHASE_GATE_STATUS.yaml

# 检查 AI PM 状态
cat docs/{feature}/AI_PM_ORCHESTRATION_STATE.yaml

# 检查项目追踪器
cat docs/_foundation/PROJECT_TRACKER.yaml

# 刷新项目状态
/project-pm check
```

### 8.3 状态恢复

```bash
# 如果 AI PM 状态异常，可以停止后重新启动
/ai-pm stop user-auth --confirm
/ai-pm start user-auth --mode=full_auto --from-phase=3

# 如果项目追踪器损坏，可以重新初始化
# （注意：会覆盖现有数据）
/project-pm init
```

---

## 9. 最佳实践

### 9.1 规划阶段

1. **仔细定义依赖关系**：在 MODULE_DECOMPOSITION 中准确描述 feature 间的依赖
2. **合理划分优先级**：高优先级 feature 会优先进入 Ready Set
3. **避免循环依赖**：初始化时会检测，但最好在规划时就避免

### 9.2 开发阶段

1. **使用独立 CLI 会话**：每个 AI PM 实例应在独立会话中运行
2. **定期检查进度**：使用 `/project-pm check` 同步状态
3. **及时处理 stuck**：不要让 stuck 状态积压太久

### 9.3 模式选择

| 场景 | 推荐模式 |
|------|----------|
| 常规功能开发 | `full_auto` |
| 关键业务功能 | `human_confirm` |
| 涉及安全/支付 | `human_confirm` |
| 原型验证 | `full_auto` |
| 首次使用框架 | `human_confirm`（便于学习） |

### 9.4 并行度控制

```yaml
# 在 PROJECT_PM_STATE.yaml 中设置
intent:
  max_parallel_features: 3  # 根据团队容量调整
```

建议：
- 小团队：1-2 个并行
- 中团队：3-5 个并行
- 大团队：5+ 个并行

### 9.5 日志和审计

1. **保留活动日志**：PROJECT_ACTIVITY_LOG 记录了所有重要活动
2. **定期查看日志**：`/project-pm logs` 了解项目动态
3. **导出报告**：完成里程碑后导出进度报告

---

## 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| v1.0 | 2026-01-11 | 初始版本，包含完整工作流说明 |

---

_Generated for Codex_
