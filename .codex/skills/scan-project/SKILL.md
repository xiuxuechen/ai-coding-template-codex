---
name: scan-project
description: Scan an existing repository to detect its tech stack, module boundaries, API and schema signals, and migration readiness before integration. Use when Codex is asked to inspect a legacy project, reverse-engineer structure, or answer requests like “扫描项目结构”, “看看这个仓库是什么技术栈”, “帮我摸清这个老项目”, “先分析一下这个 repo”, or “执行 scan-project”.
---

# Scan Project

## Overview

扫描项目结构、技术栈和关键模块，为整合或逆向分析做准备。

## Trigger Examples

- `扫描这个项目结构`
- `看看这个仓库是什么技术栈`
- `帮我摸清这个老项目`
- `执行 scan-project，先做整体分析`

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