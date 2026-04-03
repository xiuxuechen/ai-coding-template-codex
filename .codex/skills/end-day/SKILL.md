---
name: end-day
description: End the work day by consolidating progress, updating checkpoints, summarizing completed work, and preparing commit or push decisions. Use when Codex is asked to wrap up the day, prepare a handoff, or answer requests like “结束今天工作”, “收工前帮我整理一下”, “更新今天进度并保存断点”, “帮我做下班前收尾”, or “执行 end-day”.
---

# End Day

## Overview

在结束当天工作时，更新进度、生成总结、整理 Git 状态，并明确明天的第一步动作。

## Trigger Examples

- `结束今天工作，帮我整理进度`
- `收工前帮我保存断点并总结一下`
- `更新今天的 progress log`
- `执行 end-day，看看哪些变更适合提交`

## Workflow

- 定位要处理的 feature；如果用户未指定，优先根据变更文件和 `90_PROGRESS_LOG.yaml` 推断候选范围。
- 读取并更新 `docs/<feature>/90_PROGRESS_LOG.yaml`，确认今日完成项、保留唯一 `wip`、刷新 `cc_checkpoint` 和统计信息。
- 生成或汇总每日总结，明确今日完成、进行中、阻塞项和明日计划。
- 检查 Git 状态并整理推荐的 commit message，但不要自动假设所有变更都应提交。
- 只有在用户明确确认后才执行 push，并输出完整的 end-of-day 摘要。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\end-day.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\daily-summary.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\end-day.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\daily-summary.md`

## Do Not

- 不要在未确认的情况下自动 `git push`
- 不要把未完成任务直接标成 `done`
- 不要让多个任务同时保持 `wip`
- 不要忽略 `cc_checkpoint.next_step`
- 不要假装已经提交或推送成功