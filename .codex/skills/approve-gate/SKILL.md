---
name: approve-gate
description: Approve a foundation or feature phase gate after validating required role, phase, current gate state, and approval rules. Use when Codex is asked to approve a gate, record an approval decision, or answer requests like “审批 gate”, “执行 approve-gate”, “以 PM 身份通过 Phase 1”, or “记录这次 Gate 审批”.
---

# Approve Gate

## Overview

在审批 Gate 前先核验状态、角色和前置条件，再记录审批结果。

## Workflow

- 解析 feature、phase、role 和可选 user，明确当前审批范围。
- 读取对应 Gate 状态文件，确认该 Gate 不是 `locked`、不是已失败且需先修复的状态。
- 核对审批角色是否合法，检查是否满足前置产物和必要校验。
- 记录审批动作、审批人和时间戳，并在满足条件时推进 Gate 状态。
- 输出审批结果、变更内容和后续建议。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\approve-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\approve-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`

## Do Not

- 不要在未校验 phase 和 role 时直接批准
- 不要跳过现有 Gate 状态检查
- 不要伪造审批人信息
- 不要把审批通过和执行修复混为一谈
- 不要覆盖已有审批轨迹