# AI PM 状态管理 Playbook

## 目标

定义 `ai-pm-state-manager` 在 Codex 侧的保留方式，负责读取、写入、校验和恢复 `AI_PM_ORCHESTRATION_STATE.yaml`，确保 Driver 的控制态有稳定、可追溯的状态载体。

这个文档保留原 `ai_pm_state_manager` skill 的核心能力：
- 读取状态文件
- 写入状态更新并优先备份
- 校验状态一致性
- 从备份中恢复
- 严格禁止把执行事实写进控制态

## 输入

- `action`：`read`、`write`、`validate`、`restore`
- `feature`：必填
- `updates`：写入时必填
- `backup_index`：恢复时可选

## 输出

按动作输出：
- 读取结果
- 写入结果
- 校验结果
- 恢复结果

## 依赖

- 来源定义：`.codex/skill-specs/ai_pm_state_manager.md`
- 上游 / 下游流程：`ai-pm`
- 相关文件：`AI_PM_ORCHESTRATION_STATE.yaml`、`PHASE_GATE_STATUS.yaml`、`90_PROGRESS_LOG.yaml`

## 支持动作

### `read`

读取状态文件并返回：
- 是否存在
- 完整状态对象
- 错误信息

### `write`

写入更新前应：
- 校验禁止字段
- 备份旧状态
- 深度合并更新
- 保留最近备份

### `validate`

至少检查：
- 禁止字段是否存在
- 必需字段是否存在
- 枚举值是否合法
- 与 Gate / Progress 的关键一致性

### `restore`

从备份恢复到指定版本或最新版本。

## 核心规则

### 1. 禁止存储执行事实

状态文件中不得直接存储：
- `current_phase`
- `step_status`
- `completed`
- `gate_result`

这些都应从实时进度与 Gate 文件中查询。

### 2. 控制态分离

状态文件只应存：
- `intent`
- `policy`
- `runtime`
- `counters`
- `timeline`

### 3. 备份优先

每次写入前：
- 优先备份旧状态
- 再写入新状态
- 恢复路径必须可追溯

## 执行步骤

### 1. 定位状态文件

默认文件：
- `docs/{feature}/AI_PM_ORCHESTRATION_STATE.yaml`

### 2. 执行动作

根据 `action`：
- 读取
- 写入
- 校验
- 恢复

### 3. 输出结果

至少输出：
- success / failure
- 关键结果摘要
- 如失败，给出可操作错误信息

## 核心原则

1. 状态管理必须服务于编排控制，而不是替代实时执行状态。
2. 写入必须保守、可回滚、可审计。
3. 校验逻辑必须优先防止“控制态污染”。
4. 恢复能力是 Driver 可维护性的关键组成部分。

## 文档要求

- 主要内容使用中文
- `read`、`write`、`validate`、`restore`、`runtime`、`policy` 等术语可保留英文

## 验证清单

完成后检查：
1. 已定义四类动作
2. 已明确禁止字段规则
3. 已明确备份与恢复逻辑
4. 已说明与 `ai-pm` 的关系

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\ai_pm_state_manager.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ai-pm.md`
