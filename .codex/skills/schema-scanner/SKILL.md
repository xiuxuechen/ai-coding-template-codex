---
name: schema-scanner
description: Scan ORM, schema, model, or migration definitions to extract data models, fields, constraints, indexes, and relations from an existing project. Use when Codex needs to inventory database structure, reverse-engineer data models, support `scan-project`, `reverse-schema`, or legacy integration work, especially requests like “扫描数据模型”, “提取 schema”, “逆向表结构”, “看看项目有哪些实体关系”, or when there is no up-to-date data model documentation.
---

# Schema Scanner

## Overview

从 ORM、schema、实体定义或 migration 文件中提取结构化数据模型信息，帮助 Codex 理解项目的数据结构和关系图。

## Workflow

### 1. 检测 ORM / Schema 工具

优先检查：

- `prisma/schema.prisma`
- TypeORM / entity 目录
- Sequelize / Mongoose 模型目录
- Drizzle schema 文件
- SQL / migration 文件
- Python 的 `models/`、`schemas/`

### 2. 定位模型定义文件

重点搜索：

- `models/`
- `entities/`
- `schema/`
- `schemas/`
- `prisma/`
- `migrations/`

### 3. 提取模型和字段

至少提取：

- model name
- table name
- file
- line
- fields

对字段尽量提取：

- type
- db_type
- nullable
- default
- primary key
- unique
- auto increment
- foreign key
- constraints

### 4. 提取关系和索引

尽量识别：

- one-to-one
- one-to-many
- many-to-one
- many-to-many
- indexes
- unique indexes
- compound indexes

### 5. 输出关系图数据

在可行时整理：

- nodes
- edges
- relation labels

这样可以直接支撑 ER 图或数据模型文档生成。

### 6. 说明置信度与限制

优先说明：

- ORM 类型
- database type
- 解析成功的模型数
- 关系和索引覆盖度
- 哪些关系只是推断

## Typical Sources

常见支持对象：

- Prisma
- SQLAlchemy
- TypeORM
- Sequelize
- Mongoose
- Drizzle
- Django ORM
- SQL schema / migrations

## Read Only When Needed

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-schema.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\schema_scanner.md`

## Do Not

- 不要宣称连上了真实数据库，除非用户明确让你这么做并且你真的做了
- 不要把动态运行时结构硬写成静态已确认 schema
- 不要忽略关系与索引信息
- 不要因为 ORM 不常见就直接放弃全部扫描