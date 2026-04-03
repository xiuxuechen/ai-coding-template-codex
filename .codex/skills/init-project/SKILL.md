---
name: init-project
description: Initialize the project foundation by copying the required templates, creating docs/_foundation, and preparing the first gate status files. Use when Codex is asked to set up the framework in a fresh repository, bootstrap foundation docs, or answer requests like “初始化项目”, “执行 init-project”, “建立 Foundation 文档”, or “先把框架基础目录搭起来”.
---

# Init Project

## Overview

初始化项目的 Foundation 文档体系，让仓库进入可协作的框架起点。

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