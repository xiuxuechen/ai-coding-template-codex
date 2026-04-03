---
name: module-scanner
description: Scan an existing codebase to identify module boundaries, directory organization, entry points, package layout, and common layer responsibilities. Use when Codex needs to understand project structure, inventory modules, support `scan-project`, `integrate-project`, or legacy integration work, especially requests like “扫描模块”, “看看项目结构”, “分析目录组织”, “识别模块划分”, or when architecture documentation is missing or outdated.
---

# Module Scanner

## Overview

从现有项目目录和关键源码文件中提取模块划分、目录分层和入口组织方式，帮助 Codex 快速理解项目结构，并为 legacy 项目扫描、模块说明和集成评估提供基础数据。

## Workflow

### 1. 判断项目形态

优先检查：

- `package.json`
- `pnpm-workspace.yaml`
- `turbo.json`
- `nx.json`
- `go.mod`
- `pyproject.toml`
- `Cargo.toml`
- `pom.xml`
- `settings.gradle`

先判断项目更接近：

- frontend
- backend
- fullstack
- library
- cli
- monorepo

### 2. 扫描目录骨架

重点识别：

- `src/`
- `app/`
- `packages/`
- `services/`
- `modules/`
- `components/`
- `pages/` / `views/`
- `controllers/`
- `models/`
- `stores/`
- `hooks/` / `composables/`
- `utils/`
- `config/`
- `tests/`

默认排除：

- `node_modules/`
- `.git/`
- `dist/`
- `build/`
- `.next/`
- `.nuxt/`
- `coverage/`
- `__pycache__/`
- `.venv/`

### 3. 识别模块边界

至少提取：

- module name
- path
- inferred type
- file count
- entry file

尽量补充：

- 主要导出对象
- 典型责任描述
- 上下游依赖线索
- 是否属于 shared / package / app

### 4. 做模块分类

优先归类到：

- components
- views
- services
- controllers
- models
- routes
- middleware
- utils
- hooks
- stores
- types
- tests
- config
- assets

如果项目不符合这些常见类型，也要保留原始模块清单，不要强行硬套分类。

### 5. 检测 monorepo / workspace

如果发现 workspace 配置，尽量提取：

- packages
- apps
- shared libs
- package dependencies
- 入口 package

### 6. 输出结构化结果

至少包含：

- project_type
- tree summary
- modules
- categorized
- packages
- stats
- confidence

如果用户希望落盘，优先服务于：

- `scan-project`
- `integrate-project`
- 模块说明文档
- 技术栈与架构梳理

## Typical Sources

常见支持对象：

- React / Vue / Next.js / Nuxt
- Express / NestJS / Fastify / Koa
- FastAPI / Django / Flask
- Java Spring Boot
- Go Gin / Fiber
- Rust workspace
- Node / Python / Java monorepo

## Read Only When Needed

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\integrate-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\module_scanner.md`

## Do Not

- 不要把目录名推断直接写成已确认业务边界
- 不要忽略入口文件和 package 边界
- 不要为了追求完整而递归扫描大量产物目录
- 不要在没有证据时声称识别出了真实依赖图