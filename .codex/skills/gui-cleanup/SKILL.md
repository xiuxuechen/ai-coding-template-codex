---
name: gui-cleanup
description: Clean up stale, zombie, or expired GUI sessions and explain what was removed or retained. Use when Codex is asked to clean GUI sessions, remove dead connections, or troubleshoot stale GUI bridge state.
---

# GUI Cleanup

## Overview

清理无效或过期的 GUI Session，恢复 GUI 会话列表的准确性。

## Workflow

- 扫描 GUI session 状态、心跳信息和过期条件。
- 区分活跃、僵尸、陈旧和过期 session。
- 只清理可以安全删除的 session 记录。
- 输出清理结果、保留项和后续建议。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\gui-cleanup.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\hooks\check-gui-cmd.py`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\settings.json`

## Do Not

- 不要删除仍然活跃的 session
- 不要忽略心跳或最近活动时间
- 不要在未检查前做粗暴全量清理
- 不要伪造 GUI 状态恢复完成