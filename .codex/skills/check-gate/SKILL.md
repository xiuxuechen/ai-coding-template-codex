---
name: check-gate
description: Inspect foundation or feature phase gate status and explain passed, blocked, pending, or skipped conditions with evidence. Use when Codex is asked to check gate readiness, inspect blockers, or answer requests like “检查 gate”, “当前阶段能不能过”, “看看卡在哪了”, “Foundation Gate 现在什么状态”, or “执行 check-gate”.
---

# Check Gate

## Overview

检查 Foundation 或 feature Gate 的状态、阻塞项和缺失产物，判断是否具备继续推进条件。

## Trigger Examples

- `检查当前 gate 状态`
- `看看 Phase 2 能不能过`
- `Foundation Gate 现在什么状态`
- `执行 check-gate，列出缺失项`

## Workflow

- 确定要检查的是 Foundation Gate 还是某个 feature 的 Phase Gate。
- 读取对应的 Gate 配置和状态文件，提取 `passed`、`blocked`、`pending`、`skipped`、`locked` 等状态。
- 核对必要文档、测试、评审和审批项是否存在且与当前 phase 匹配。
- 汇总缺失项、风险和阻塞原因，明确哪些条件仍未满足。
- 输出结构化检查结果，并给出下一步建议。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\gate-checker\SKILL.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\next-phase.md`

## Do Not

- 不要把缺失产物说成已满足
- 不要忽略 `blocked` 或 `locked` 状态
- 不要跳过 Foundation Gate 与 Feature Gate 的区别
- 不要用主观判断代替状态文件证据
- 不要在检查过程中擅自审批 Gate