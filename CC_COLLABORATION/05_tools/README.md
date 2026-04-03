# 05_tools - 工具定义

> 版本：v3.1
> 最后更新：2026-01-11
> 状态：已实现

---

## 为什么需要工具？

> 我们发现，光有模板还不够。模板解决了「输出什么」的问题，但没有解决「怎么触发」和「怎么串联」的问题。
>
> **问题**：每次让 AI 做一件事，都要重复解释一遍上下文、输入、输出、约束条件。AI 理解了，但下次又忘了。
>
> **解决方案**：把常用的操作封装成**工具**，定义好触发条件、输入输出、执行逻辑。这样 AI 只需要「调用工具」而不是「从头理解任务」。
>
> 工具是模板的「执行层」——模板定义格式，工具负责生成、验证、更新这些格式化的内容。通过工具，我们把团队的工作流程固化下来，让 AI 成为流程的执行者，而不是每次都需要手把手指导的新手。

---

## 工具概览

| 类型 | 数量 | 说明 |
|------|------|------|
| **Slash Commands** | 25 | 用户显式调用的命令（`/xxx`） |
| **Skills** | 6 | Codex 自动判断何时应用的能力 |
| **Subagents** | 5 | 独立执行复杂任务的子代理 |
| **总计** | **36** | |

**三者的核心区别**：

| 类型 | 触发方式 | 特点 |
|------|----------|------|
| **Slash Commands** | 用户显式输入 `/xxx` | 入口统一，功能丰富 |
| **Skills** | Codex 自动匹配触发 | 无需用户调用，根据对话内容自动应用 |
| **Subagents** | 通过 Task tool 调用 | 独立上下文，适合研究型任务 |

---

## 目录结构

```
05_tools/
├── README.md              # 本文件
├── slash-commands/        # 25 个 Slash Commands
├── skills/                # 6 个 Skills
└── subagents/             # 5 个 Subagents
```

---

## Slash Commands（25 个）

### 按功能分类

#### 每日工作流

| 命令 | 用途 | 使用场景 |
|------|------|----------|
| `/start-day` | 开始一天工作 | 每天早上第一件事 |
| `/end-day` | 结束一天工作 | 下班前保存进度 |
| `/iresume` | 恢复上下文 | 从断点继续工作 |
| `/check-progress` | 查看进度 | 了解当前状态 |
| `/daily-summary` | 生成每日总结 | 记录当天工作 |

#### 功能开发

| 命令 | 用途 | Phase |
|------|------|-------|
| `/new-feature` | 创建新功能模块 | Phase 1 |
| `/gen-demo` | 生成 Demo | Phase 3 |
| `/run-tests` | 执行测试 | Phase 6 |
| `/release` | 发布版本 | Phase 7 |

#### Phase Gate 管理

| 命令 | 用途 | 说明 |
|------|------|------|
| `/check-gate` | 检查 Gate 状态 | 验证是否满足通过条件 |
| `/approve-gate` | 审批 Gate | 人工确认通过 |
| `/next-phase` | 进入下一阶段 | Gate 通过后执行 |
| `/expert-review` | 专家评审 | 调用 OpenAI 独立评审 |
| `/ai-pm` | AI PM 编排驱动器 | 自动化多阶段功能开发流程 |

#### Foundation 阶段

| 命令 | 用途 | 说明 |
|------|------|------|
| `/init-project` | 初始化项目 | 创建 _foundation 目录 |
| `/doc-design-validation` | 验证设计文档 | Foundation Gate 检查 |
| `/plan-features` | 生成功能清单 | 从 User Journey 提取 |

#### Legacy 项目整合

| 命令 | 用途 | 说明 |
|------|------|------|
| `/integrate-project` | 整合现有项目 | 纳入框架管理 |
| `/scan-project` | 扫描项目结构 | 识别技术栈和模块 |
| `/reverse-api` | 逆向生成 API 文档 | 从代码生成 |
| `/reverse-schema` | 逆向生成数据模型 | 从 ORM 生成 |
| `/sync-docs` | 同步文档 | 检查代码与文档一致性 |

#### GUI 连接（HA Loop Desk）

| 命令 | 用途 | 说明 |
|------|------|------|
| `/gui-connect` | 连接 GUI | 建立与工作台的连接 |
| `/gui-disconnect` | 断开 GUI | 断开连接 |
| `/gui-cleanup` | 清理 GUI Session | 清理过期会话 |

---

## Skills（6 个）

> **Skills 是 Codex 自动判断何时应用的能力**，不需要用户显式调用。
>
> 与 Slash Commands 不同，Skills 通过自然语言描述匹配来触发。当用户的需求符合某个 Skill 的触发条件时，Codex 会自动应用该 Skill。

| Skill | 触发条件 | 用途 |
|-------|----------|------|
| `doc_generator` | 用户说「生成文档」「创建 SPEC」等 | 根据模板生成标准化文档 |
| `review_alignment` | 用户说「检查一致性」或任务完成后 | 检查代码与设计文档是否一致 |
| `ui_demo` | 用户说「做个 demo」「生成原型」 | 生成可运行的 UI Demo |
| `mock_api_generator` | 用户说「mock 接口」「前端先用假数据」 | 生成 Mock API 代码 |
| `design_from_demo` | Demo 评审后，用户说「整理成正式设计」 | 从 Mock API 反推正式设计文档 |
| `ai_pm_state_manager` | `/ai-pm` 命令调用 | 管理 AI PM Driver 状态文件（读写、验证、备份） |

**为什么精简到 5 个？**

之前的 15 个 Skills 中，大部分实际是「被 Command 调用的内部逻辑」，而非「Codex 自动触发的能力」。根据 Codex 官方定义，这些内部逻辑已合并到对应的 Slash Commands 中：

- `gate_checker` → 合并到 `/check-gate`
- `progress_updater` → 合并到 `/check-progress`, `/end-day`
- `test_runner` → 合并到 `/run-tests`
- `context_writer` → 合并到 `/new-feature`
- 其他类似处理...

---

## Subagents（5 个）

Subagents 是独立执行复杂任务的子代理，有自己的执行上下文和输出。

| Subagent | Phase | 用途 |
|----------|-------|------|
| `spec_writer` | Phase 2 | 根据 CONTEXT 生成 SPEC |
| `progress_tracker` | Phase 5 | 解析进度，生成 DAILY_SUMMARY |
| `test_plan_writer` | Phase 6 | 根据 SPEC 生成测试计划 |
| `expert_reviewer` | Phase 4-6 | 独立评审设计和代码 |
| `release_summarizer` | Phase 7 | 汇总生成发布说明 |

---

## 工具与 Phase 的对应关系

```
Phase 0 Foundation    → /init-project, /doc-design-validation, /plan-features
Phase 1 Kickoff       → /new-feature
Phase 2 Spec          → spec_writer (subagent)
Phase 3 Demo          → /gen-demo, ui_demo*, mock_api_generator*
Phase 4 Design        → design_from_demo*, expert_reviewer (subagent)
Phase 5 Code          → /iresume, review_alignment*
Phase 6 Test          → /run-tests, test_plan_writer (subagent)
Phase 7 Deploy        → /release, release_summarizer (subagent)

跨阶段通用            → /start-day, /end-day, /check-progress, /daily-summary
                      → /check-gate, /approve-gate, /next-phase, /expert-review
                      → /ai-pm, ai_pm_state_manager*
                      → doc_generator*

* = Skills（自动触发）
```

---

## 工具状态说明

| 状态 | 图标 | 说明 |
|------|------|------|
| 已实现 | ✔️ | 已完成并可用 |
| 实现中 | 🚧 | 正在开发 |
| 计划中 | 📝 | 规格已定义，待实现 |

**当前状态**：所有 36 个工具均已实现 ✔️

---

## 如何添加新工具

### 1. 定义规格

在对应目录创建 `.md` 文件，包含：

```markdown
# 工具名称

## 元信息
- 类型: Command / Skill / Subagent
- Phase: 适用阶段
- 优先级: P0 / P1 / P2

## 用途
描述工具的作用

## 使用方式
```bash
/command-name {参数}
```

## 执行逻辑
1. 步骤一
2. 步骤二
...

## 输入
- 输入 1
- 输入 2

## 输出
- 输出 1
- 输出 2
```

### 2. 实现工具

- **Slash Commands**: 在 `.codex/commands/` 创建对应文件
- **Skills**: 在 `.codex/skill-specs/` 创建对应文件
- **Subagents**: 在 `.codex/subagents/` 创建对应文件

### 3. 更新文档

更新本 README 中的工具列表。

---

## 相关目录

- `01_workflow/` - 工作流说明
- `03_templates/` - 文档模板
- `07_phase_gate/` - Phase Gate 机制

---

_CC_COLLABORATION Framework v3.1_
