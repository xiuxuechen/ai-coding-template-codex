---
name: ai-pm
description: Drive the AI PM orchestration loop by checking driver state, delegating to existing workflows, and deciding whether to continue, pause, or escalate. Use when Codex is asked to run the PM driver or answer requests like “启动 AI PM”, “查看 PM Driver 状态”, “继续自动推进流程”, “暂停当前编排”, or “执行 ai-pm”.
---

# AI PM

## Overview

把 AI PM 作为编排层来驱动流程推进，而不是直接替代执行层。

## Trigger Examples

- `启动 AI PM`
- `查看 PM Driver 状态`
- `继续自动推进流程`
- `执行 ai-pm，先看当前 driver 状态`

## Workflow

- 读取当前 driver 状态和 feature 进度，先判断是否允许继续推进。
- 根据子命令或用户意图决定是 `start`、`status`、`pause`、`resume`、`confirm`、`reject` 还是 `stop`。
- 将具体动作委托给现有 skills 或工作流，而不是在本 skill 内伪造执行结果。
- 记录状态变化、等待点和下一检查条件。
- 输出编排摘要，包括当前状态、最近动作和下一建议。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\ai-pm.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ai-pm.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ai-pm-state-manager.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\ai-pm-state-manager\SKILL.md`

## Do Not

- 不要把编排层当成执行引擎
- 不要伪造 gate、测试或评审结果
- 不要忽略 driver 当前状态就强行推进
- 不要在没有证据时改写 feature 完成状态
- 不要跳过暂停、卡住或待确认状态