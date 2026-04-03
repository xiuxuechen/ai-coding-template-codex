---
name: changelog-updater
description: Update document changelogs for context, spec, or design changes. Use when Codex needs to record versioned documentation changes, especially during doc generation, spec updates, design updates, or release summarization.
---

# Changelog Updater

## Overview

为 `10_CONTEXT.md`、`20_API_SPEC.md`、`21_UI_FLOW_SPEC.md`、`40_DESIGN_FINAL.md` 等文档维护对应的 CHANGELOG，保持变更历史可追踪。

## Workflow

### 1. 识别主文档和 CHANGELOG

根据文档类型定位对应文件：

- `context` -> `10_CONTEXT_CHANGELOG.md`
- `spec` -> `11_SPEC_CHANGELOG.md`
- `design` -> `40_DESIGN_CHANGELOG.md`

### 2. 读取现有记录

如果 CHANGELOG 已存在，先读取最近条目，避免重复或乱序。

### 3. 生成新条目

记录至少包括：

- 版本号
- 日期
- 变更类型 `added / changed / fixed / removed`
- 变更描述

### 4. 写回并保持倒序

把最新变更插入到顶部，保持时间顺序清晰。

### 5. 需要时同步主文档

如果主文档也需要版本字段更新，再一并处理，但不要顺手重写整份文档。

## Read When Needed

在需要更完整流程时读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\doc-generator.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\spec-writer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\release-summarizer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\changelog_updater.md`

## Do Not

- 不要改无关文档
- 不要伪造版本号
- 不要把 changelog 写成长篇说明
- 不要覆盖已有历史记录