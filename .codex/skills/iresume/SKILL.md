---
name: iresume
description: Restore prior work context from progress logs, checkpoints, and referenced files for a specific feature. Use when Codex is asked to resume interrupted work, restore the last checkpoint, or answer requests like “恢复上下文”, “继续昨天那个功能”, “帮我找回上次做到哪了”, “恢复这个 feature 的断点”, or “执行 iresume”.
---

# IResume

## Overview

根据 feature 的进度日志和 checkpoint 恢复工作上下文，明确当前阶段、上次操作和下一步。

## Trigger Examples

- `恢复这个 feature 的上下文`
- `继续昨天那个功能`
- `帮我找回上次做到哪了`
- `执行 iresume，读取最近 checkpoint`

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