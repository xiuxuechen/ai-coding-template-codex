---
name: contract-resolver
description: Resolve real API and entity contracts before writing frontend calls, mock data, type definitions, or response handling. Use when Codex needs the true field names, types, constraints, or endpoint shapes from project sources such as contract files, OpenAPI, API specs, backend schemas, backend models, or existing frontend types. Trigger for requests like “查真实字段”, “确认接口字段名”, “生成 Mock 前先看 contract”, “Mock 切真实接口”, or when Codex is about to guess names such as `userName` vs `username` or `createdAt` vs `created_at`.
---

# Contract Resolver

## Overview

在编写接口调用、类型定义、Mock 数据和响应处理逻辑之前，先查找项目里的单一信息来源，尽量避免 AI 靠猜测写字段名。

## Workflow

### 1. 明确查询目标

支持两类主查询：

- 按实体查询：例如 `User`、`Agent`、`Order`
- 按端点查询：例如 `GET /api/users`、`POST /api/orders`

如果用户没有明确给出查询目标，但当前任务明显依赖真实契约，先从当前 feature、代码上下文或页面需求里推断最可能的实体或端点。

### 2. 按优先级查找 SSoT

按以下顺序查找，找到较高质量来源时优先返回：

1. 项目 contract 文件
2. OpenAPI / Swagger
3. API SPEC / UI FLOW SPEC 文档
4. 后端 schema 定义
5. 后端 model 定义
6. 前端类型定义

优先级高的来源覆盖优先级低的来源，不要把前端类型定义当成最高可信来源。

### 3. 提取契约事实

至少整理：

- 真实字段名
- 字段类型
- required / nullable
- format / enum / default
- 嵌套对象结构
- 对端点场景，额外整理 method、path、request body、response body、status codes

### 4. 输出结构化结果

至少输出：

- 来源文件
- 来源类型
- 字段列表
- 置信度
- 置信度原因

如果用户需要，可额外生成：

- TypeScript 类型定义
- Mock 数据示例
- Zod schema 草稿

### 5. 在存在冲突时显式告警

如果多个来源互相冲突：

- 明确列出采用了哪个来源
- 明确指出被忽略的来源
- 解释冲突点，例如 `createdAt` vs `created_at`

### 6. 在找不到定义时给出可执行下一步

如果没有找到 contract：

- 列出已搜索的位置
- 说明当前无法确认真实字段名
- 建议补 `20_API_SPEC.md`、OpenAPI 或 contract 文件

## SSoT Priority

常见搜索路径：

- `shared/contracts/{entity}.yaml`
- `contracts/{entity}.json`
- `openapi.yaml`
- `swagger.json`
- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/21_UI_FLOW_SPEC.md`
- `app/schemas/{entity}.py`
- `src/schemas/{entity}.ts`
- `prisma/schema.prisma`
- `app/models/{entity}.py`
- `src/models/{entity}.ts`
- `src/types/{entity}.ts`
- `src/api/types.ts`

## Typical Uses

适用场景：

- 写前端组件前确认真实字段名
- 写 Mock 数据前确认返回结构
- 从 Mock 切真实接口前做字段比对
- 生成 TypeScript 类型前确认 SSoT
- 检查 API 文档、schema、实现之间是否冲突

## Read Only When Needed

在需要更完整的 legacy 接入上下文时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\08_legacy_integration\README.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\contract_resolver.md`

## Do Not

- 不要在没有查到真实定义时假装字段名已确认
- 不要优先相信低优先级前端类型而忽略后端 schema
- 不要把推断结果伪装成权威契约
- 不要只给最终类型定义，不说明来源和置信度