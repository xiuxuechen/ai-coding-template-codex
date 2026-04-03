---
name: scan-project
description: Scan an existing project to identify its structure, modules, APIs, schema sources, and technology stack before integrating it into the framework. Use when Codex is asked to inspect a legacy or unfamiliar repository, reverse-engineer its shape, or prepare migration context.
---

# Scan Project

## Overview

扫描项目结构、技术栈和关键模块，为整合或逆向分析做准备。

## Workflow

- 确认扫描目标路径和范围。
- 识别技术栈、主要目录、入口文件、模块边界、API 和数据源。
- 提取适合后续整合的关键信息和风险点。
- 输出结构化扫描摘要，并说明下一步适合走整合、逆向还是补文档。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\tech-stack-detector\SKILL.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\module-scanner\SKILL.md`

## Do Not

- 不要只看单个目录就下结论
- 不要把推断写成已经确认的事实
- 不要忽略入口文件和构建配置
- 不要遗漏扫描范围和不确定项