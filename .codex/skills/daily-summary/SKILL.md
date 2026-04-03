---
name: daily-summary
description: Generate a daily work summary from one or more 90_PROGRESS_LOG.yaml files, including completed tasks, work in progress, blockers, and tomorrow's priorities. Use when Codex is asked to summarize today's work, create a daily report, consolidate progress across features, or answer requests like “生成每日总结”, “执行 daily-summary”, “汇总今天做了什么”, or “给我一份今日工作报告”.
---

# Daily Summary

## Overview

根据今日更新过的进度日志生成单功能或全局每日总结，沉淀完成项、进行中、阻塞项和明日计划。

## Workflow

- 判断范围是单个 feature 还是全局汇总。
- 读取对应的 `90_PROGRESS_LOG.yaml`，提取今日完成项、`wip`、阻塞项和最新进度。
- 生成结构化的每日总结内容，必要时写入 `91_DAILY_SUMMARY/<date>.md`。
- 对比最近进度，提炼今日变化和明日优先事项。
- 输出控制台摘要，并明确生成文件路径或跳过原因。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\daily-summary.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\daily-summary.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-progress.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\end-day.md`

## Do Not

- 不要把非今日完成的任务算进今日完成列表
- 不要在没有依据时捏造进度增量
- 不要忽略阻塞项或 `wip`
- 不要在无更新时假装今天有成果
- 不要漏写生成文件路径或范围说明