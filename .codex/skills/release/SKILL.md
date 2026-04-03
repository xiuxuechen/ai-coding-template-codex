---
name: release
description: Prepare a release summary for a feature and version by collecting progress, test evidence, changelog entries, and delivery notes. Use when Codex is asked to create release notes, summarize a deliverable, or answer requests like “执行 release”, “生成发布说明”, “整理这个 feature 的版本发布内容”, or “为 v1.0.0 出一份 release note”.
---

# Release

## Overview

汇总发布所需的进度、测试和变更信息，生成结构化发布说明。

## Workflow

- 解析 feature 和 version，确认发布范围。
- 读取 `70_RELEASE_NOTE.md`、`71_CHANGELOG.md`、测试报告和进度日志等相关产物。
- 汇总新功能、修复、改进、已知问题和发布前置条件。
- 检查是否存在明显缺失的测试、审批或 Gate 证据。
- 输出或更新发布说明，并标注发布准备状态。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\release.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\release.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\release-summarizer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\release-summarizer\SKILL.md`

## Do Not

- 不要伪造已完成的测试或审批结果
- 不要跳过版本号或范围确认
- 不要把 rehearsal 结果当成真实生产发布
- 不要遗漏已知问题和风险说明
- 不要只列文件名而不形成发布摘要