---
name: context-writer
description: Turn a natural-language feature request into a structured `10_CONTEXT.md` document. Use when Codex needs to start a new feature, capture user stories, define scope and constraints, or prepare the input for `doc-generator`, especially requests like “写 CONTEXT”, “整理需求上下文”, “生成功能背景”, or when the user gives a rough feature description that still needs structure.
---

# Context Writer

## Overview

把用户的自然语言需求整理成结构化的 `10_CONTEXT.md`，明确功能目标、用户故事、边界、约束和依赖。

## Workflow

### 1. 提炼需求要点

先从需求描述里提取：

- 核心功能点
- 目标用户
- 业务价值
- 已知约束
- 依赖项

### 2. 组织用户故事

把需求整理成可追踪的 user stories，并补充基础验收标准，避免后续 SPEC 阶段再返工补脑。

### 3. 明确边界

明确写出：

- In Scope
- Out of Scope
- 依赖
- 风险或不确定项

### 4. 输出上下文文档

生成适合交给 `doc-generator` 的上下文内容，保持章节清晰、术语一致、可直接进入后续文档生成流程。

## Read Only When Needed

在需要更完整的上下文时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\new-feature.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\spec-writer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\context_writer.md`

## Do Not

- 不要把模糊需求直接伪装成完整设计
- 不要遗漏边界和依赖
- 不要跳过用户故事编号
- 不要在缺少信息时假装已经确认范围