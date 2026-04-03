---
name: system-scaffolder
description: Generate the project directory skeleton and Foundation bootstrap files from a PROJECT_PROFILE. Use when Codex needs to initialize a new project, create the `_foundation` structure, or prepare the repository before the first feature starts, especially requests like “生成项目脚手架”, “初始化目录结构”, “搭建 Foundation”, or when `01_PROJECT_PROFILE.yaml` already exists and the repo needs deterministic scaffolding.
---

# System Scaffolder

## Overview

根据 `01_PROJECT_PROFILE.yaml` 生成项目目录结构、基础配置和 Foundation 起始文件，作为 Phase 0 / Foundation 初始化的入口。

## Workflow

### 1. 读取项目配置

优先读取：

- `docs/_system/01_PROJECT_PROFILE.yaml`
- 用户显式传入的 `profile_path`

先确认：

- 项目类型 `frontend` / `backend` / `fullstack`
- 技术栈
- 是否需要 demo / test / backend / frontend 目录

### 2. 选择脚手架模板

根据项目类型和技术栈选择要创建的目录与基础文件。优先保留已存在文件，只补缺失项，不做破坏性覆盖。

### 3. 创建基础目录

常见目录包括：

- `docs/_foundation/`
- `docs/_foundation/_planning/`
- `docs/_foundation/_api_system/`
- `docs/_foundation/_db_system/`
- `docs/_foundation/_ui_system/`
- `src/`、`tests/`、`frontend/`、`backend/` 等项目级目录

### 4. 生成基础文件

按项目栈生成最小启动文件，例如：

- `.gitignore`
- `README.md`
- `vite.config.ts`
- `tsconfig.json`
- `package.json`
- `prisma/schema.prisma`
- `FOUNDATION_GATE_STATUS.yaml`

### 5. 输出结果

至少返回：

- 创建的目录
- 创建的文件
- 已存在而跳过的文件
- 配置摘要

## Read Only When Needed

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\plan-features.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\system_scaffolder.md`

## Do Not

- 不要覆盖用户已有的业务文件
- 不要把推断当成已确认的项目事实
- 不要跳过已存在目录的保护检查
- 不要在没有 `PROJECT_PROFILE` 的情况下硬造完整脚手架