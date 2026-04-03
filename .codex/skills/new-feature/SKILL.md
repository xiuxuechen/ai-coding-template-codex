---
name: new-feature
description: Create a new feature workspace under docs/, initialize the required documents and phase gate files, and prepare the feature for kickoff. Use when Codex is asked to start a new feature, open a feature track, bootstrap feature docs, or answer requests like “新建功能”, “执行 new-feature”, “创建一个 user-auth feature”, or “给这个需求建一套文档骨架”.
---

# New Feature

## Overview

在 `docs/<feature>/` 下创建新功能骨架，初始化核心文档、Gate 文件和首轮上下文入口。

## Workflow

- 验证 feature 名称和目标路径，确认不会误覆盖已有 feature。
- 创建 `docs/<feature>/` 目录及关键文档骨架。
- 初始化 `PHASE_GATE.yaml`、`PHASE_GATE_STATUS.yaml`、`90_PROGRESS_LOG.yaml` 等运行态文件，并写入真实 feature 元数据。
- 指出首轮需要填写的 CONTEXT、SPEC 或设计文档。
- 输出 feature 已创建的文件列表和下一步建议。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\new-feature.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\new-feature.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\template-consumption.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\context-writer\SKILL.md`

## Do Not

- 不要在已有同名 feature 上静默覆盖
- 不要留下未经实例化的 phase gate 占位符
- 不要跳过 `90_PROGRESS_LOG.yaml` 初始化
- 不要把模板复制误说成需求已经完成
- 不要在缺少 feature 名称时强行猜测