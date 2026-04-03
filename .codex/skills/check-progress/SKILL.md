---
name: check-progress
description: Inspect detailed progress for a feature or provide a portfolio-wide overview using progress logs and task stats. Use when Codex is asked to check status, inspect blockers, or answer requests like “查看进度”, “看看现在做到哪了”, “给我一个全局进度概览”, “当前有哪些阻塞项”, or “执行 check-progress”.
---

# Check Progress

## Overview

从 `90_PROGRESS_LOG.yaml` 提取进度、阶段状态和下一里程碑，输出单功能详情或全局概览。

## Trigger Examples

- `查看当前进度`
- `给我一个全局进度概览`
- `看看 user-auth 现在做到哪了`
- `执行 check-progress，顺便列出阻塞项`

## Workflow

- 判断用户要看单个 feature 还是全局概览。
- 读取一个或多个 `90_PROGRESS_LOG.yaml`，提取 `meta`、`stats`、当前 phase 和任务状态。
- 对单功能输出详细视图，包括当前阶段、任务分布、下一里程碑和阻塞情况。
- 对全局输出概览视图，包括 feature 列表、完成度、活跃/阻塞/完成统计。
- 给出后续建议，例如使用 `iresume` 恢复上下文或聚焦当前 `wip`。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-progress.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-progress.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\iresume.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\start-day.md`

## Do Not

- 不要把缺失日志的 feature 假装成正常
- 不要篡改 `90_PROGRESS_LOG.yaml` 里的状态
- 不要只报百分比而忽略阻塞项和 `next_step`
- 不要把全局概览误写成单 feature 详情
- 不要虚构里程碑或任务统计