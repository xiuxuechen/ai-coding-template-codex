---
name: reverse-schema
description: Reverse-engineer data models, field constraints, and entity relationships from ORM, schema, or SQL definitions to produce a maintainable data model document. Use when Codex needs to generate schema docs from code, support legacy onboarding, or handle requests like “逆向数据模型”, “从 ORM 生成文档”, “补表结构说明”, or after `integrate-project`.
---

# Reverse Schema

## Overview

从 ORM、schema 或 migration 文件逆向提取数据模型和关系，输出可维护的数据模型文档，为 legacy 项目整合和后续文档同步提供基线。

## Workflow

### 1. 检测数据源

优先识别：

- Prisma
- TypeORM
- Sequelize
- Mongoose
- Drizzle
- SQL / migrations

### 2. 调用扫描线索

优先结合：

- `schema-scanner`
- 现有模型定义
- migration 文件

至少提取：

- model / table name
- fields
- types
- constraints
- relations
- source file

### 3. 生成关系和约束说明

尽量保留：

- 主键与唯一约束
- 外键关系
- 一对多 / 多对多线索
- 需要人工确认的 `[推断]` 关系

### 4. 生成逆向文档

如需落盘，目标通常是：

- `docs/{feature}/_foundation/03_DATA_MODEL.md`

要求：

- 统一标记 `[逆向]`
- 关系不确定时标记 `[推断]`
- 保留数据源类型和限制说明

### 5. 给出后续同步建议

完成后通常建议：

- `sync-docs`
- `schema-generator`
- `review-alignment`

## Read Only When Needed

在需要上下游规则时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-schema.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\integrate-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\sync-docs.md`

## Do Not

- 不要宣称连上了真实数据库，除非你真的做了
- 不要美化或猜测业务语义
- 不要忽略字段来源和关系不确定性
- 不要把逆向结果写成原始设计文档事实