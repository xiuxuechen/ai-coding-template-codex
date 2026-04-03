---
name: iresume
description: Resume a feature from its latest checkpoint by reading 90_PROGRESS_LOG.yaml, restoring cc_checkpoint, and surfacing the next actionable step. Use when Codex is asked to continue previous work, restore a feature context, reload the latest session, or answer requests like “继续上次的工作”, “执行 iresume”, “恢复断点”, or “帮我找回刚才做到哪了”.
---

# IResume

## Overview

根据 feature 的进度日志和 checkpoint 恢复工作上下文，明确当前阶段、上次操作和下一步。

## Workflow

- 确定目标 feature；如果未指定，先扫描 `docs/` 下可恢复的 feature 并列出候选项。
- 读取 `docs/<feature>/90_PROGRESS_LOG.yaml`，检查 `meta`、`stats`、`cc_checkpoint` 是否存在。
- 提取 `session_id`、`last_file_edited`、`last_action`、`next_step` 和 `context_files`。
- 按需补充读取 `10_CONTEXT.md`、`40_DESIGN_FINAL.md`、最近编辑文件等关键上下文。
- 输出恢复摘要，并在继续执行前指出当前最优先的下一步。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\iresume.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\iresume.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-progress.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-progress.md`

## Do Not

- 不要在 feature 不明确时假装已经恢复成功
- 不要忽略缺失的 `90_PROGRESS_LOG.yaml`
- 不要无依据编造 `next_step`
- 不要在恢复前修改任务状态
- 不要把不存在的上下文文件说成已读取