---
name: release-summarizer
description: Generate a structured `70_RELEASE_NOTE.md` by summarizing progress logs, test reports, changelogs, and feature context. Use when Codex needs to prepare release notes, summarize a completed feature, support `release`, or assess whether a feature is ready to ship, especially requests like “生成发布说明”, “汇总 release note”, “整理上线说明”, or after testing and gate checks are complete.
---

# Release Summarizer

## Overview

汇总进度、测试、CHANGELOG 和功能背景，生成结构化发布说明，帮助团队基于真实交付证据做发布决策。

## Workflow

### 1. 收集发布材料

优先读取：

- `90_PROGRESS_LOG.yaml`
- `61_TEST_REPORT.md`
- `70_RELEASE_NOTE.md`（如果是增量更新）
- `*_CHANGELOG.md`
- `10_CONTEXT.md`

必要时补充：

- `40_DESIGN_FINAL.md`
- `20_API_SPEC.md`
- `21_UI_FLOW_SPEC.md`

### 2. 提取可发布信息

至少整理：

- 已完成的功能点
- 重要改进
- 已修复问题
- 遗留已知问题
- 测试结果摘要
- 版本号与发布时间线索

如果材料不足：

- 明确标记缺失项
- 不要虚构发布亮点或测试通过率

### 3. 分类变更内容

建议按以下结构分类：

- 新功能
- 改进
- 修复
- 已知问题
- 升级或使用提示

### 4. 生成发布说明

建议文档至少包含：

- 版本概述
- 变更摘要
- 测试摘要
- 已知问题
- 风险提示
- 相关链接或参考文档

如果用户要求落盘，目标文件通常是：

- `docs/{feature}/70_RELEASE_NOTE.md`

### 5. 联动发布状态

在需要时同步说明或更新：

- `release.version`
- `release.released_at`
- `release.release_notes`
- `meta.status`

如果没有足够证据支撑正式发布，应该明确给出风险，而不是默认建议发布。

## Read Only When Needed

在需要上下游约束时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\release-summarizer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\release.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`

## Do Not

- 不要编造发布版本或发布时间
- 不要隐藏失败测试或已知问题
- 不要把未交付的功能写成已上线能力
- 不要用空泛描述替代真实变更证据