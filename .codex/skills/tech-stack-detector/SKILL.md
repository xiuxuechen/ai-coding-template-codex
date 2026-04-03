---
name: tech-stack-detector
description: Detect the primary language, runtime, package manager, frameworks, build tools, databases, testing stack, UI libraries, and monorepo signals from an existing project. Use when Codex needs to identify the real tech stack, support `scan-project`, choose the right implementation path, or understand an unfamiliar repository, especially requests like “识别技术栈”, “看看这是用什么框架”, “分析项目依赖”, “判断前后端栈”, or when project documentation is missing or stale.
---

# Tech Stack Detector

## Overview

从配置文件、依赖声明和关键代码线索中识别项目的真实技术栈，帮助 Codex 选择正确的分析路径、实现方式和后续工具链。

## Workflow

### 1. 定位关键配置文件

优先检查：

- `package.json`
- `pnpm-lock.yaml` / `yarn.lock` / `package-lock.json`
- `pyproject.toml` / `requirements.txt` / `poetry.lock`
- `go.mod`
- `Cargo.toml`
- `pom.xml` / `build.gradle`
- `Dockerfile`
- `.nvmrc`
- `.python-version`

### 2. 识别语言与包管理器

至少提取：

- primary language
- runtime version hints
- package manager
- config file source

如果存在多语言项目，保留主语言和辅助语言，不要只报其中一种。

### 3. 识别框架和工具链

尽量提取：

- frontend framework
- backend framework
- build tool
- test framework
- lint / format tool
- ui library
- css framework

### 4. 推断数据库与 ORM

优先根据以下线索判断：

- ORM 依赖
- schema 文件
- migration 目录
- 数据库驱动包
- 环境变量示例

### 5. 判断项目类型

判断并说明：

- is_frontend
- is_backend
- is_fullstack
- is_library
- is_cli
- is_monorepo

### 6. 给出置信度和来源

至少说明：

- 识别依据来自哪些文件
- 哪些结论是直接命中依赖
- 哪些结论带有推断性质
- 当前技术栈识别的覆盖度

## Typical Sources

常见支持对象：

- React / Next.js / Vue / Nuxt / Angular
- Express / NestJS / Fastify / Koa / Hono
- FastAPI / Django / Flask
- Spring Boot
- Gin / Fiber
- Prisma / TypeORM / Sequelize / Mongoose / SQLAlchemy / Drizzle
- Vite / Webpack / Turbopack / esbuild
- Jest / Vitest / Playwright / Cypress / Pytest

## Read Only When Needed

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\integrate-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\tech_stack_detector.md`

## Do Not

- 不要因为存在单个依赖就武断认定整套技术栈
- 不要把示例代码依赖误判为生产主栈
- 不要在没有证据时宣称真实运行时版本
- 不要忽略 monorepo 或多语言项目中的次级栈