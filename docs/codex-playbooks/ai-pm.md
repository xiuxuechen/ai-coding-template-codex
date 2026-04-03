# AI PM 编排 Playbook

## 目标

保留 `AI PM Driver` 作为编排层的能力，让其在 Codex 侧继续承担“决策何时做什么、何时暂停、何时请求人工确认”的职责，而不是直接变成执行引擎。

这个文档保留原 `/ai-pm` 的核心能力：
- 定义 Driver 的状态机和子命令语义
- 启动、暂停、恢复、停止、确认、拒绝等控制动作
- 依据 Gate 和进度状态做实时决策
- 将执行动作委托给已有 playbooks / skills
- 把控制态与执行事实分离

## 输入

- 子命令：`start`、`status`、`pause`、`resume`、`stop`、`confirm`、`reject`、`skip`、`compare`、`logs`、`restart`
- 功能名称：通常必填
- 模式：`full_auto`、`human_confirm`
- 起始阶段：可选

## 输出

至少产出：
- Driver 当前状态
- 当前阶段与 Gate 状态摘要
- 最近决策与原因
- 下一步自动动作或待人工动作

## 依赖

- 来源定义：`.codex/commands/ai-pm.md`
- 状态管理：`ai-pm-state-manager`
- 依赖执行流：`check-gate`、`approve-gate`、`next-phase`、`expert-review` 等
- 相关文档：`90_PROGRESS_LOG.yaml`、`PHASE_GATE_STATUS.yaml`

## 子命令语义

### `start`

启动 Driver。
要求：
- 功能目录存在
- 当前没有正在运行的 Driver
- 起始阶段前置 Gate 已通过或允许跳过

### `status`

展示 Driver 当前状态、计数器、最近决策和时间线。

### `pause` / `resume` / `stop`

控制 Driver 执行节奏：
- `pause`：临时冻结自动编排
- `resume`：从暂停或卡住状态恢复
- `stop`：停止当前 Driver 会话

### `confirm` / `reject`

处理 `waiting_human` 状态：
- `confirm`：批准当前决策继续推进
- `reject`：拒绝当前动作，并让 Driver 进入 `stuck`

### `skip`

仅在明确定义允许跳过的阶段或 `stuck` 场景中使用。

### `compare` / `logs` / `restart`

用于查看差异、查看历史决策轨迹或在失败后重新开始。

## 执行步骤

### 1. 解析子命令

先确定：
- 子命令类型
- feature
- mode
- from-phase
- 其他选项

### 2. 校验 feature 与依赖文件

至少确认：
- `docs/{feature}/90_PROGRESS_LOG.yaml`
- `docs/{feature}/PHASE_GATE_STATUS.yaml`

### 3. 读取或初始化 Driver 状态

通过 `ai-pm-state-manager` 读取 `AI_PM_ORCHESTRATION_STATE.yaml`。

### 4. 依据子命令执行控制逻辑

要求：
- Driver 只做编排决策
- 执行动作委托给现有能力
- 不把实时执行事实直接写回控制态

### 5. 输出状态与下一步

至少包含：
- 当前运行状态
- 当前阶段
- 最近决策
- 下一动作
- 如需人工确认，则输出等待原因

## 核心原则

1. AI PM Driver 是 orchestration layer，不是 execution engine。
2. 控制态与执行事实必须分离。
3. 决策依据应尽量来自实时检查，而不是过期缓存。
4. `waiting_human`、`stuck`、`paused` 等状态必须有清晰语义。

## 文档要求

- 主要内容使用中文
- `AI PM Driver`、`orchestration layer`、`full_auto`、`human_confirm`、`stuck` 等术语可保留英文

## 验证清单

完成后检查：
1. 已定义主要子命令语义
2. 已说明 Driver 与执行引擎的边界
3. 已说明状态文件与实时信息的关系
4. 已明确人工确认与卡住状态的处理方式

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\ai-pm.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ai-pm-state-manager.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
