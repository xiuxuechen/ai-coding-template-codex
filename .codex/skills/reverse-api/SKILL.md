---
name: reverse-api
description: Reverse-engineer API documentation from existing code by detecting frameworks, routes, handlers, parameters, and response shapes. Use when Codex is asked to extract API contracts from a codebase or answer requests like “从代码逆向 API”, “帮我把接口文档反推出来”, “扫描一下后端路由”, “看看现有接口长什么样”, or “执行 reverse-api”.
---

# Reverse API

## Overview

从现有后端代码中逆向提取接口定义，整理成可维护的 API 文档，为 legacy 项目接入、文档同步和契约确认提供稳定基线。

## Trigger Examples

- `从代码逆向 API`
- `帮我把接口文档反推出来`
- `扫描一下后端路由`
- `执行 reverse-api，输出成 markdown`

## Workflow

### 1. 检测框架与入口

优先判断：

- 后端框架
- 路由入口
- 控制器文件
- 校验 schema 或类型定义位置

### 2. 调用扫描线索

优先结合：

- `api-scanner`
- `contract-resolver`
- 现有 API 文档或注释

至少提取：

- method
- path
- handler
- source file
- line

### 3. 推断请求与响应

尽量整理：

- 路径参数
- 查询参数
- 请求体字段
- 响应结构
- 鉴权与 middleware 线索

不确定内容要标记为 `[推断]`。

### 4. 生成逆向文档

如需落盘，目标通常是：

- `docs/{feature}/20_API_SPEC.md`

要求：

- 统一标记 `[逆向]`
- 保留来源位置
- 标出置信度或待确认点

### 5. 给出后续同步建议

完成后通常建议：

- `sync-docs`
- `review-alignment`
- `contract-resolver`

## Read Only When Needed

在需要上下游规则时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-api.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\sync-docs.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\integrate-project.md`

## Do Not

- 不要伪造真实调用结果
- 不要把推断字段写成已确认契约
- 不要忽略来源文件与行号
- 不要因为框架识别不完整就直接放弃所有输出