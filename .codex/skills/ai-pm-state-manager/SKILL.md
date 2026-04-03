---
name: ai-pm-state-manager
description: Read, write, validate, and restore the AI PM orchestration state file when Codex needs to manage `AI_PM_ORCHESTRATION_STATE.yaml` without mixing control state with execution facts. Use when the task is about maintaining PM driver state, backup, recovery, or consistency checks, especially when the user mentions AI PM, orchestration state, or state validation.
---

# AI PM State Manager

## Overview

这是 AI PM Driver 的状态管理器。它只负责控制态的读写、校验和恢复，不存储执行事实，也不替代阶段任务本身的状态文件。

## Workflow

### 1. 先区分控制态和执行事实

如果当前输入包含：

- current_phase
- step_status
- completed
- gate_result

先判断这些是不是执行事实。若是，不要写入 `AI_PM_ORCHESTRATION_STATE.yaml`。

### 2. 处理状态操作

支持四类操作：

- read：读取当前状态
- write：深度合并写入，并在写前备份
- validate：检查字段、枚举值和一致性
- restore：从备份恢复

### 3. 保持备份优先

每次写入前优先备份现有状态，恢复时优先使用最近的可用备份。

### 4. 验证控制态一致性

校验至少包含：

- 必需字段是否存在
- forbidden fields 是否被误写入
- runtime / intent 的枚举值是否合法
- 是否与 `PHASE_GATE_STATUS.yaml`、`90_PROGRESS_LOG.yaml` 保持一致

## Read Only When Needed

在需要更完整的上下文时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\ai_pm_state_manager.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ai-pm.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ai-pm-state-manager.md`

## Do Not

- 不要把执行事实写进控制态文件
- 不要跳过备份直接覆盖状态
- 不要把状态管理和阶段执行混为一谈
- 不要在校验失败时假装状态仍然一致