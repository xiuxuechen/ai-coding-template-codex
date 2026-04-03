---
name: api-scanner
description: Scan an existing codebase to extract API routes, handlers, parameters, middleware, and response hints from backend source files. Use when Codex needs to inventory endpoints, reverse-engineer APIs, support `scan-project`, `reverse-api`, or legacy integration work, especially requests like “扫描接口”, “提取路由”, “逆向 API”, “看看项目有哪些端点”, or when a framework-specific route map is missing.
---

# API Scanner

## Overview

从现有项目代码中提取 API 端点定义，输出结构化端点清单，为逆向 API 文档、契约解析和 legacy 项目接入提供基础数据。

## Workflow

### 1. 检测框架与语言

优先从以下线索判断：

- `package.json`
- `requirements.txt`
- `go.mod`
- `pom.xml`
- 导入语句与装饰器语法
- 常见目录名，如 `routes/`、`controllers/`、`api/`、`views/`

### 2. 定位路由相关文件

重点搜索：

- `routes/`
- `router/`
- `controllers/`
- `api/`
- `*.controller.*`
- 含 `route`、`router`、`controller`、`handler` 语义的文件

### 3. 提取端点核心信息

至少提取：

- HTTP method
- path
- handler
- file
- line

尽量补充：

- 路径参数
- 查询参数
- 请求体类型或 schema 线索
- 响应类型或状态码
- middleware / decorators
- 是否需要鉴权
- tags / description

### 4. 给出置信度

对每个端点标记：

- `high`：框架元数据清晰，类型信息可追溯
- `medium`：能识别 method/path，但类型信息不完整
- `low`：只提取到部分信息或依赖较强推断

### 5. 组织结构化输出

至少包含：

- framework
- language
- endpoints
- modules
- stats

如果用户需要落盘，优先服务于：

- `reverse-api`
- `scan-project`
- `sync-docs`

## Typical Sources

常见支持对象：

- FastAPI
- Express
- NestJS
- Koa
- Fastify
- Hono
- Django / Flask
- Gin

如果框架不在显式名单里，也要先尝试提取通用路由模式，不要因为识别不全就直接放弃。

## Read Only When Needed

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-api.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\api_scanner.md`

## Do Not

- 不要伪装成执行了真实 API 调用
- 不要把推断的字段结构写成已确认事实
- 不要忽略来源文件与行号
- 不要因为个别文件解析失败就丢掉整个扫描结果