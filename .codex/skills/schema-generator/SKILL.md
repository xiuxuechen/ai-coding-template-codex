---
name: schema-generator
description: Generate database schema files and migration drafts from the finalized design model. Use when Codex needs to turn `40_DESIGN_FINAL.md` into Prisma, TypeORM, SQL, or Mongoose schema output, especially requests like “生成 Schema”, “从设计生成数据库结构”, “建表草稿”, or when backend data models are already defined and should be translated into a concrete persistence layer.
---

# Schema Generator

## Overview

根据 `40_DESIGN_FINAL.md` 中的数据模型定义，生成数据库 schema、实体草稿或迁移草稿，帮助后续数据库实现保持与设计一致。

## Workflow

### 1. 读取设计模型

优先读取：

- `docs/{feature}/40_DESIGN_FINAL.md`
- 相关的 `20_API_SPEC.md` / `21_UI_FLOW_SPEC.md`（如需交叉确认）

重点提取：

- 实体名
- 字段名与类型
- required / nullable
- enum / default
- relation
- index / unique 约束

### 2. 选择目标格式

支持常见输出：

- `prisma`
- `typeorm`
- `sql`
- `mongoose`

优先按项目现有技术栈和用户显式要求选择，不要强行统一到某一种格式。

### 3. 生成 schema 草稿

按字段、关系、约束生成可落地的 schema 文件或迁移草稿，并尽量保留命名映射、外键和索引信息。

### 4. 检查设计一致性

如果模型定义缺失、冲突或不完整，先标出问题，不要把不确定内容写成最终事实。

### 5. 输出结果

至少返回：

- 目标格式
- 生成的 schema 内容
- 迁移注意点
- 需要人工确认的字段或关系

## Read Only When Needed

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\plan-features.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-schema.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\schema_generator.md`

## Do Not

- 不要凭空补全未定义字段
- 不要把推断的关系写成已确认关系
- 不要忽略索引、唯一约束和外键
- 不要在没有设计依据时直接生成破坏性迁移