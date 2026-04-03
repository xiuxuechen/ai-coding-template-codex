# 数据模型逆向生成 Playbook

## 目标

从 ORM、Schema 或 SQL 定义中逆向提取数据模型、字段约束和实体关系，生成一份可维护的数据模型文档。

这个 playbook 保留原 `/reverse-schema` 的核心能力：
- 检测数据源类型
- 解析模型和字段
- 提取关系定义
- 生成带 `[逆向]` 标记的数据模型文档
- 为后续文档同步提供基线

## 输入

- 项目路径：必填
- 输出路径：可选
- ORM 类型：可选
- 是否包含关系图：可选，默认建议开启

## 输出

默认建议输出到：
- `docs/{feature}/_foundation/03_DATA_MODEL.md`

文档至少应包含：
- 模型总览
- 字段定义
- 关系定义
- 数据源说明
- 验证清单

## 依赖

- 参考命令：`.codex/commands/reverse-schema.md`
- 可复用 utilities：`schema-scanner`
- 后续相关 playbooks：`integrate-project`、`sync-docs`

## 支持范围

优先支持：
- Prisma
- TypeORM
- Sequelize
- Mongoose
- Drizzle
- SQL 文件

不同数据源允许置信度不同，但都应尽量保留来源和限制说明。

## 执行步骤

### 1. 检测数据源

按优先级识别：
- `prisma/schema.prisma`
- TypeORM 实体目录
- Sequelize 模型目录
- Mongoose schema 文件
- Drizzle schema 文件
- SQL 与 migration 文件

如果识别不明确：
- 允许人工指定 ORM
- 输出中说明检测依据不足

### 2. 提取模型定义

至少提取：
- 模型名称
- 表名或实体名
- 字段名
- 字段类型
- 主要约束
- 来源文件

### 3. 提取关系定义

尽量提取：
- 一对一
- 一对多
- 多对一
- 多对多
- 外键字段

如果关系无法确定：
- 标记为 `[推断]`
- 不强行宣称关系类型

### 4. 生成数据模型文档

建议文档结构：
- 概述
- 模型列表
- 实体关系图
- 每个模型的详细定义
- 验证清单
- 数据库来源信息
- 元数据

要求：
- 文档主要内容使用中文
- `Prisma`、`TypeORM`、`ER Diagram` 等术语可保留英文
- 逆向生成内容统一标记为 `[逆向]`
- 需要确认的部分标记为 `[推断]`

### 5. 输出统计与后续建议

至少给出：
- 模型数量
- 关系数量
- 字段总数
- 数据源类型
- 后续建议，例如执行 `sync-docs`

## 核心原则

1. 优先保留真实结构，不美化不猜测业务语义。
2. 业务含义不明确时，先保留字段事实，再提示补充语义。
3. 来源文件要可追溯。
4. 关系图是辅助信息，不能替代字段明细。

## 验证清单

完成后检查：
1. 已识别数据源类型
2. 已输出模型列表和字段定义
3. 已尽量提取实体关系
4. 不确定内容已标为 `[推断]`
5. 输出文档已明确标注 `[逆向]`

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\reverse-schema.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\integrate-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\sync-docs.md`
