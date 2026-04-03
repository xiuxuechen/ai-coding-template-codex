# API 逆向生成 Playbook

## 目标

从现有代码中逆向提取 API 路由、请求参数、响应结构和来源位置，生成一份可供后续维护的 API 文档。

这个 playbook 保留原 `/reverse-api` 的核心能力：
- 识别后端框架
- 定位路由文件
- 提取端点定义
- 推断请求与响应结构
- 生成带 `[逆向]` 标记的 API 文档

## 输入

- 项目路径：必填
- 输出路径：可选
- 输出格式：可选，支持 `markdown` 或 `openapi`
- 指定框架：可选

## 输出

产出一份逆向 API 文档，默认建议为：
- `docs/{feature}/20_API_SPEC.md`

文档至少应包含：
- API 概述
- 端点列表
- 端点详细定义
- 来源文件位置
- 置信度或待验证提示

## 依赖

- 参考命令：`.codex/commands/reverse-api.md`
- 可复用 utilities：`api-scanner`、`contract-resolver`
- 后续相关 playbooks：`scan-project`、`integrate-project`、`sync-docs`

## 支持范围

优先支持以下常见框架：
- Express
- Koa
- NestJS
- Fastify
- Hono

如果框架识别不完整，也应尽量输出部分逆向结果，不要因为不完美而完全放弃。

## 执行步骤

### 1. 检测框架

优先从：
- `package.json`
- 路由定义方式
- 目录结构
中识别框架。

如果无法可靠识别：
- 允许用户手动指定
- 同时在输出中标记识别不确定

### 2. 定位路由与控制器文件

重点查找：
- `src/routes/`
- `src/router/`
- `routes/`
- `src/**/*.controller.ts`
- 其他包含 `route`、`router`、`controller` 的文件

### 3. 提取端点定义

至少提取：
- HTTP 方法
- 路径
- handler 名称
- 来源文件与行号

尽量补充：
- 路径参数
- 查询参数
- 请求体结构
- 响应结构
- middleware 或鉴权线索

### 4. 推断类型信息

优先读取：
- TypeScript 类型定义
- 校验 schema，例如 Zod、Joi
- JSDoc 注释
- 返回值形态

如果无法确认：
- 标记为 `[推断]`
- 保留待人工验证提示
- 不要伪造高确定性描述

### 5. 生成 API 文档

建议文档结构：
- 概述
- 端点总览
- 模块分组
- 每个端点的详细说明
- 验证清单
- 生成元数据

文档要求：
- 标题和说明使用中文
- `GET`、`POST`、`OpenAPI`、`handler` 等术语可保留英文
- 所有逆向结果统一标记为 `[逆向]`
- 需要人工确认的内容标记为 `[推断]`

### 6. 输出统计与后续建议

至少给出：
- 端点总数
- 高/中/低置信度分布
- 参与分析的文件
- 推荐下一步，例如执行 `sync-docs`

## 核心原则

1. 逆向结果首先追求可用，再追求完整。
2. 不确定的信息必须显式标记。
3. 来源位置要尽可能精确到文件或行号。
4. 生成的是可维护文档，不只是一次性扫描结果。

## 验证清单

完成后检查：
1. 已识别主要路由文件
2. 已提取端点列表
3. 结果中包含来源文件信息
4. 不确定内容已标为 `[推断]`
5. 输出文档已明确标注 `[逆向]`

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\reverse-api.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\sync-docs.md`
