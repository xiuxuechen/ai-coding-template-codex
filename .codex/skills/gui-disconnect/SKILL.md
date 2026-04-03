---
name: gui-disconnect
description: Remove the current GUI bridge session and stop accepting GUI-originated commands for this terminal. Use when Codex is asked to disconnect from the GUI bridge or answer requests like “断开 GUI”, “关闭 GUI 连接”, “把当前终端从 GUI 里移除”, or “执行 gui-disconnect”.
---

# GUI Disconnect

## Overview

断开当前终端与 GUI 的连接，并把它从会话列表中移除。

## Trigger Examples

- `断开 GUI`
- `关闭 GUI 连接`
- `把当前终端从 GUI 里移除`
- `执行 gui-disconnect`

## Workflow

- 检查当前终端是否存在活跃 GUI session。
- 定位与当前终端绑定的 session 记录。
- 移除或停用该 session，并清理残留状态。
- 输出断开结果和任何需要手动处理的残留项。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\gui-disconnect.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\settings.json`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\hooks\check-gui-cmd.py`

## Do Not

- 不要误删其他终端的 session
- 不要在未连接时谎称断开成功
- 不要留下脏状态而不说明
- 不要把断开与全局清理混为一谈