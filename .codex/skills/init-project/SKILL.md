---
name: init-project
description: Initialize the project foundation by copying required templates, creating the foundation document tree, and establishing baseline gate state. Use when Codex is asked to initialize a new repository, bootstrap the framework, or answer requests like “初始化项目框架”, “先把 Foundation 搭起来”, “帮我建立基础文档目录”, “给这个仓库做初始化”, or “执行 init-project”.
---

# Init Project

## Overview

初始化项目的 Foundation 文档体系，让仓库进入可协作的框架起点。

## Trigger Examples

- `初始化这个项目`
- `先把 Foundation 搭起来`
- `帮我建立基础文档目录`
- `执行 init-project，在当前仓库初始化`

## Workflow

- 确认当前目录适合初始化，并检查是否已存在 `docs/_foundation`。
- 从 Foundation 模板复制必要文件和目录到目标位置。
- 初始化 Gate 状态文件和基础元数据，避免保留未实例化占位符。
- 说明哪些文档已生成、哪些还需要补充内容。
- 输出下一步建议，例如先做 Foundation 文档或执行 `plan-features`。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\template-consumption.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\system-scaffolder\SKILL.md`

## Do Not

- 不要静默覆盖现有 Foundation 文档
- 不要复制后留下未实例化的关键占位符
- 不要跳过状态文件初始化
- 不要把 feature 级文档混进 Foundation 目录
- 不要假装模板复制成功却未校验目标结果