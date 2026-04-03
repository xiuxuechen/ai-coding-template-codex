---
name: next-phase
description: Advance a feature to the next development phase only after checking gate status, required artifacts, and current phase boundaries. Use when Codex is asked to move forward, promote a feature, or answer requests like “进入下一阶段”, “帮我推进到下一个 phase”, “看看现在能不能进入 Phase 4”, “把这个功能往后推进一步”, or “执行 next-phase”.
---

# Next Phase

## Overview

在确认当前 Gate 与阶段条件满足后，把 feature 安全推进到下一开发阶段。

## Trigger Examples

- `进入下一阶段`
- `帮我推进到下一个 phase`
- `看看现在能不能进 Phase 4`
- `执行 next-phase，顺便说下下一步`

## Workflow

- 确认目标 feature 当前所处的 phase 与状态。
- 检查当前 phase 的 Gate 是否已满足或是否存在明确可跳过条件。
- 决定下一阶段编号、所需初始化动作和新阶段的关注重点。
- 更新相关状态文件、进度日志和必要的模板骨架。
- 输出推进结果、阻塞原因或下一阶段的第一步动作。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\next-phase.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\next-phase.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`

## Do Not

- 不要在 Gate 未通过时强行推进
- 不要跳过当前 phase 证据校验
- 不要修改阶段但不更新进度日志
- 不要忽略 skip 或 blocked 的特殊语义
- 不要把进入下一阶段和完成阶段动作混为一谈