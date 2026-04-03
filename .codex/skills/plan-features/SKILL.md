---
name: plan-features
description: Produce a feature development order and checklist from foundation module decomposition and dependency information. Use when Codex is asked to plan feature rollout, derive sequencing, or answer requests like “规划 feature 顺序”, “给我一个开发优先级列表”, “根据模块拆分生成开发顺序”, “先排一下这些功能怎么做”, or “执行 plan-features”.
---

# Plan Features

## Overview

根据模块拆分和依赖关系生成可执行的 feature 开发顺序清单。

## Trigger Examples

- `规划一下 feature 顺序`
- `给我一个开发优先级列表`
- `根据模块拆分生成开发顺序`
- `执行 plan-features，标出依赖关系`

## Workflow

- 读取模块拆分和相关 Foundation 文档，提取 feature 候选项。
- 校验必要字段、依赖关系和可能的循环依赖。
- 按优先级、前置关系和协作风险整理 feature 顺序。
- 生成结构化的 feature checklist 或规划结果。
- 输出排序依据和建议的下一步创建顺序。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\plan-features.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\plan-features.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\context-writer\SKILL.md`

## Do Not

- 不要批量创建所有 feature 目录来替代规划
- 不要忽略循环依赖
- 不要只给排序不给依据
- 不要从不完整文档中硬凑完整清单
- 不要把规划结果说成已经执行创建