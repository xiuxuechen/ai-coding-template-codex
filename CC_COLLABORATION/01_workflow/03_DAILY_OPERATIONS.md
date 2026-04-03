# AI 协作开发框架 - 每日操作指南

> 适用于：日常开发中查阅 | 阅读时间：按需

---

## 一、每日工作流程

### 1.1 一天的标准流程

```
上班
  │
  ▼
/start-day ─────────────────┐
  │                         │
  │  ① 拉取最新代码          │
  │  ② 显示今日待办          │
  │  ③ 检查依赖更新          │
  │                         │
  ▼                         │
选择任务                     │
  │                         │
  ▼                         │
/iresume {feature} ─────────┤
  │                         │
  │  ① 读取 PROGRESS_LOG    │
  │  ② 恢复 checkpoint      │
  │  ③ 加载相关文档          │
  │                         │
  ▼                         │
开发工作                     │
  │                         │
  │  • 编写代码              │
  │  • 更新文档              │
  │  • 测试验证              │
  │                         │
  ▼                         │
/end-day ───────────────────┤
  │                         │
  │  ① 更新 PROGRESS_LOG    │
  │  ② 保存 checkpoint      │
  │  ③ 提交代码              │
  │  ④ 生成每日总结          │
  │                         │
  ▼                         │
下班                        │
```

### 1.2 命令详解

#### /start-day

**作用**：开始新的一天工作

**执行内容**：
1. `git pull` 拉取最新代码
2. 检查 `package.json` 变化，提示 `npm install`
3. 扫描所有功能的 PROGRESS_LOG
4. 显示今日待办任务列表

**输出示例**：
```
📅 2026-01-09 工作日开始

📥 代码同步
✓ 已拉取最新代码 (main: abc1234)
✓ 无依赖更新

📋 今日待办
┌─────────────┬──────────┬─────────────────────┐
│ 功能        │ 阶段     │ 下一步              │
├─────────────┼──────────┼─────────────────────┤
│ user-auth   │ Phase 5  │ 实现登录 API 调用    │
│ dashboard   │ Phase 3  │ 等待 Demo 评审       │
└─────────────┴──────────┴─────────────────────┘

💡 执行 /iresume user-auth 开始工作
```

#### /iresume {feature}

**作用**：恢复功能开发上下文（最重要的命令）

**执行内容**：
1. 读取 `90_PROGRESS_LOG.yaml`
2. 提取 `cc_checkpoint` 信息
3. 加载 `context_files` 列表中的文件
4. 显示当前状态和下一步

**触发时机**：
- 新对话开始
- 对话被 compact
- 切换功能开发
- 忘记之前做了什么

**输出示例**：
```
🔄 恢复上下文: user-auth

📍 Checkpoint
├── 会话: cc-2026-01-08-003
├── 最后编辑: src/views/Login.vue
├── 最后操作: 完成登录表单验证
└── 下一步: 实现登录 API 调用

📄 已加载文档
├── 10_CONTEXT.md
├── 40_DESIGN_FINAL.md
└── 50_DEV_PLAN.md

📊 进度: Phase 5 (Code) - 60%
├── ✓ 项目结构初始化
├── ✓ 登录页面 UI
├── ✓ 表单验证逻辑
├── ○ 登录 API 调用 ← 当前
└── ○ 错误处理

💡 继续: 实现登录 API 调用
```

#### /end-day

**作用**：结束一天工作，保存进度

**执行内容**：
1. 更新 PROGRESS_LOG 中的任务状态
2. 保存 cc_checkpoint（下次恢复点）
3. `git add && git commit && git push`
4. 生成当日工作总结

**输出示例**：
```
📤 保存今日进度

✓ 更新 PROGRESS_LOG
  ├── TASK-003: done (登录表单验证)
  └── TASK-004: wip (登录 API 调用)

✓ 保存 Checkpoint
  └── next_step: "完成登录 API 错误处理"

✓ 代码提交
  └── feat(auth): 实现登录表单验证逻辑

📊 今日总结
├── 完成: 2 个任务
├── 进行中: 1 个任务
├── 代码变更: +150 / -20 行
└── 功能进度: Phase 5 (60% → 75%)
```

---

## 二、上下文恢复详解

### 2.1 为什么需要上下文恢复？

Codex 的对话有 context window 限制，当对话过长时会被压缩（compact），导致：
- 忘记之前讨论的内容
- 不知道当前进度
- 重复提问或重复工作

**解决方案**：将关键信息写入文档，通过 `/iresume` 恢复。

### 2.2 Checkpoint 结构

```yaml
cc_checkpoint:
  session_id: "cc-2026-01-08-003"           # 会话标识
  last_file_edited: "src/views/Login.vue"   # 最后编辑的文件
  last_action: "完成登录表单验证"            # 最后完成的操作
  next_step: "实现登录 API 调用"             # 下一步任务
  context_files:                             # 需要读取的上下文文件
    - "docs/user-auth/10_CONTEXT.md"
    - "docs/user-auth/40_DESIGN_FINAL.md"
    - "docs/user-auth/50_DEV_PLAN.md"
  blockers: []                               # 当前阻塞项
  notes: "注意登录失败的错误处理"             # 其他备注
```

### 2.3 恢复流程

```
/iresume {feature}
       │
       ▼
读取 PROGRESS_LOG
       │
       ├── 获取 cc_checkpoint
       ├── 获取当前阶段
       └── 获取任务列表
       │
       ▼
读取 context_files
       │
       ├── 10_CONTEXT.md (功能背景)
       ├── 40_DESIGN_FINAL.md (设计文档)
       └── 50_DEV_PLAN.md (开发计划)
       │
       ▼
确认当前状态
       │
       ├── next_step 是否有效？
       ├── 是否有 blockers？
       └── 需要调整吗？
       │
       ▼
继续工作
```

### 2.4 何时执行 /iresume

| 场景 | 是否需要 | 原因 |
|------|---------|------
| 新对话开始 | **是** | 新对话没有任何上下文 |
| 对话被 compact | **是** | 历史信息被压缩 |
| 切换到另一个功能 | **是** | 需要加载不同功能的上下文 |
| 感觉 Codex 忘了什么 | **是** | 主动恢复上下文 |
| 同一对话内继续工作 | 否 | 上下文还在 |

---

## 三、进度管理

### 3.1 PROGRESS_LOG 结构

```yaml
# docs/{feature}/90_PROGRESS_LOG.yaml

meta:
  feature_id: "user-auth"
  feature_name: "用户认证模块"
  current_phase: 5
  current_phase_name: "Code"
  started_at: 2026-01-05
  updated_at: 2026-01-08

tasks:
  - id: TASK-001
    task: "创建登录页面 UI"
    status: done
    completed_at: 2026-01-06

  - id: TASK-002
    task: "实现表单验证"
    status: done
    completed_at: 2026-01-07

  - id: TASK-003
    task: "实现登录 API 调用"
    status: wip

  - id: TASK-004
    task: "实现错误处理"
    status: pending

  - id: TASK-005
    task: "实现 Token 存储"
    status: pending

cc_checkpoint:
  session_id: "cc-2026-01-08-003"
  last_file_edited: "src/views/Login.vue"
  last_action: "完成登录表单验证"
  next_step: "实现登录 API 调用"
  context_files:
    - "docs/user-auth/10_CONTEXT.md"
    - "docs/user-auth/40_DESIGN_FINAL.md"
  blockers: []
  notes: ""
```

### 3.2 任务状态流转

```
pending ──────▶ wip ──────▶ done
   │             │
   │             │
   │             ▼
   │          blocked
   │             │
   │             │
   └─────────────┘
       (解除阻塞后)
```

| 状态 | 说明 | 操作 |
|------|------|------
| pending | 待开始 | 开始时改为 wip |
| wip | 进行中 | 完成时改为 done |
| done | 已完成 | 不再变更 |
| blocked | 阻塞 | 解除后回到 pending 或 wip |

### 3.3 查看进度

```bash
/check-progress user-auth
```

**输出示例**：
```
📊 功能进度: user-auth

🎯 当前阶段: Phase 5 (Code)
📈 整体进度: ████████░░ 80%

📋 任务状态
├── ✓ TASK-001: 创建登录页面 UI
├── ✓ TASK-002: 实现表单验证
├── ○ TASK-003: 实现登录 API 调用 [wip]
├── ○ TASK-004: 实现错误处理 [pending]
└── ○ TASK-005: 实现 Token 存储 [pending]

⏱️ 预计完成: 2026-01-10
```

---

## 四、阶段转换

### 4.1 Phase 转换流程

```
Phase N 开发完成
       │
       ▼
/check-gate ─────────────────┐
       │                     │
       │  检查：             │
       │  ① 必需产出物       │
       │  ② 质量要求         │
       │  ③ 审批状态         │
       │                     │
       ▼                     │
    通过？                   │
    ┌──┴──┐                  │
    │     │                  │
   是    否                  │
    │     │                  │
    │     └─▶ 修复问题 ──────┘
    │
    ▼
/approve-gate ───────────────┐
       │                     │
       │  人工审批：         │
       │  ① PM 审批          │
       │  ② Architect 审批   │
       │                     │
       ▼                     │
/next-phase                  │
       │                     │
       │  ① 更新 phase       │
       │  ② 生成新阶段任务   │
       │                     │
       ▼                     │
进入 Phase N+1               │
```

### 4.2 Gate 命令

```bash
# 检查是否满足通过条件
/check-gate user-auth --phase=5

# 审批通过（需要指定角色）
/approve-gate user-auth --phase=5 --role=Developer

# 进入下一阶段
/next-phase user-auth
```

---

## 五、常见场景

### 5.1 场景：中途需要切换功能

```bash
# 1. 保存当前功能进度
/end-day  # 或手动更新 checkpoint

# 2. 切换到另一个功能
/iresume dashboard

# 3. 开始工作
# ...

# 4. 切换回来
/iresume user-auth
```

### 5.2 场景：对话被 compact

当看到 "context compacted" 提示时：

```bash
# 立即执行恢复
/iresume user-auth

# Codex 会自动读取：
# - PROGRESS_LOG（进度）
# - cc_checkpoint（断点）
# - context_files（相关文档）
```

### 5.3 场景：不知道做到哪了

```bash
# 查看进度
/check-progress user-auth

# 恢复上下文
/iresume user-auth
```

### 5.4 场景：遇到阻塞

```bash
# 1. 在 PROGRESS_LOG 中记录阻塞
blockers:
  - task_id: TASK-003
    description: "登录 API 返回 CORS 错误"
    error_message: "..."
    tried_solutions:
      - "添加代理配置"
      - "修改请求头"
    needs_help: true

# 2. 标记任务状态
tasks:
  - id: TASK-003
    status: blocked

# 3. 继续其他任务或寻求帮助
```

---

## 六、最佳实践

### 6.1 每日必做

1. **上班**：`/start-day`
2. **开始功能**：`/iresume {feature}`
3. **下班**：`/end-day`

### 6.2 对话管理

- 对话变长时主动 `/iresume`
- 不要在一个对话里做太多不相关的事
- 重要决策及时记录到文档

### 6.3 进度同步

- 完成任务立即更新 PROGRESS_LOG
- checkpoint 信息要完整（尤其是 next_step）
- 阻塞要详细记录

---

## 下一步

- 想查阅完整命令参考？→ [04_REFERENCE.md](./04_REFERENCE.md)
- 想了解框架原理？→ [02_FRAMEWORK_OVERVIEW.md](./02_FRAMEWORK_OVERVIEW.md)
- 想快速上手？→ [01_QUICKSTART.md](./01_QUICKSTART.md)

---

_文档版本：v2.0 | 最后更新：2026-01-09_
