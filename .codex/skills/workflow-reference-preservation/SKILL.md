---
name: workflow-reference-preservation
description: Load the right workflow reference material from `CC_COLLABORATION/01_workflow` and `07_phase_gate` so Codex preserves the original framework’s stage model, terminology, recipes, and gate semantics. Use when Codex needs methodology context, explain the framework, map old concepts to Codex playbooks, or handle requests like “解释框架流程”, “看 workflow reference”, “恢复 Phase Gate 语义”, or “找对应 recipe”.
---

# Workflow Reference Preservation

## Overview

负责保留和调用原框架的解释层知识，让 Codex 不只保留命令和模板，还保留 `8+1` 阶段模型、`Foundation Gate`、`Recipe`、`PM Driver` 等方法论语义。

## Workflow

### 1. 先判断当前需要执行说明还是方法论参考

- 具体执行：优先进入对应 playbook 或 skill
- 理解框架或恢复思路：优先读取 workflow reference

### 2. 按场景选择最小必要参考

常见映射：

- 首次上手：`README.md` + `01_QUICKSTART.md`
- 整体框架：`02_FRAMEWORK_OVERVIEW.md`
- 日常节奏：`03_DAILY_OPERATIONS.md`
- PM 机制：`05_PM_DRIVER_WORKFLOW.md`
- Gate 规则：`07_phase_gate/README.md`
- 专题场景：读取对应 `recipes/*.md`

### 3. 保留关键术语与阶段语义

迁移后仍应保留：

- `8+1`
- `Phase 0.5`
- `Foundation Gate`
- `Phase Gate`
- `Expert Review`
- `PM Driver`
- `Recipe`

### 4. 建立参考与执行映射

输出时尽量说明：

- 当前参考文档解决什么问题
- 对应的 Codex playbook 是什么
- 对应的 skill 或未来脚本是什么

### 5. 处理载体变化

如果原框架是 command，而 Codex 现在是 playbook 或 skill：

- 保留原能力语义
- 明确说明承载方式变化
- 不把载体变化误判为能力缺失

## Read Only When Needed

在需要方法论参考时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\workflow-reference-preservation.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\01_workflow\`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\07_phase_gate\README.md`

## Do Not

- 不要默认把整套 workflow 文档全部读入上下文
- 不要把参考文档当成执行结果模板
- 不要抹掉原框架关键术语
- 不要把能力承载方式变化说成能力消失