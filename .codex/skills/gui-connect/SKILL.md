---
name: gui-connect
description: Register the current Codex session as a GUI bridge session so an external GUI can discover and interact with it. Use when Codex is asked to connect the CLI to a GUI bridge or answer requests like “连接 GUI”, “开启 GUI 模式”, “把当前终端接到控制台”, or “执行 gui-connect”.
---

# GUI Connect

## Overview

将当前终端注册为 GUI Session，供外部 GUI 发现和下发命令。

## Trigger Examples

- `连接 GUI`
- `开启 GUI 模式`
- `把当前终端接到控制台`
- `执行 gui-connect`

## Workflow

- 检查当前目录是否具备 `.codex/` 所需结构。
- 定位或创建当前终端的 GUI session 元数据。
- 初始化必要的 session 信息和心跳机制。
- 说明连接结果、session 标识和后续使用方式。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\gui-connect.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\hooks\check-gui-cmd.py`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\settings.json`

## Do Not

- 不要在无项目目录时伪造连接成功
- 不要覆盖其他活跃终端的 session
- 不要省略 session 标识
- 不要把实验性 GUI bridge 说成完全无风险