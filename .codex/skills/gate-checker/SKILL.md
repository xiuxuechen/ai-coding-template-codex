---
name: gate-checker
description: Check Phase Gate readiness for a feature by verifying required outputs, quality checks, approvals, and External Gate status. Use when Codex needs to run gate checks, decide whether a phase can advance, or inspect gate blockers before `/check-gate`, `/approve-gate`, or a phase transition.
---

# Gate Checker

## Overview

检查某个功能模块的 Phase Gate 是否满足进入下一阶段的条件，并输出清晰的阻断原因、待办和下一步建议。

## Workflow

### 1. 确认目标

先确定：

- `feature`
- `phase`
- 当前阶段配置和状态文件

### 2. 读取 Gate 事实源

优先读取：

- `docs/{feature}/PHASE_GATE.yaml`
- `docs/{feature}/PHASE_GATE_STATUS.yaml`
- 必要时联读相关设计、测试或评审文档

### 3. 检查三类条件

依次检查：

- `required_outputs`
- `quality_checks`
- `approvals`

同时检查 `External Gate` 是否已通过，且不要把它当作可被普通阶段状态覆盖的结果。

### 4. 汇总结果

输出至少包含：

- `overall_state`
- 缺失项
- 失败的质量检查
- 待审批项
- `blocked_reasons`
- `next_actions`

### 5. 必要时写回状态

如果当前流程要求持久化结果，再更新 `PHASE_GATE_STATUS.yaml`，保持状态与事实一致。

## Read When Needed

在需要更完整流程时读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\approve-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\gate_checker.md`

## Do Not

- 不要手动改 `gate_state`
- 不要编造审批记录或检查证据
- 不要忽略 External Gate
- 不要把“可继续”误写成“已通过”