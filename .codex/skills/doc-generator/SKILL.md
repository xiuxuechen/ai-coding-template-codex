---
name: doc-generator
description: Generate standard project documents from templates and feature context, especially `10_CONTEXT.md`, `20_API_SPEC.md`, `21_UI_FLOW_SPEC.md`, `40_DESIGN_FINAL.md`, `60_TEST_PLAN.md`, `70_RELEASE_NOTE.md`, and `71_CHANGELOG.md`. Use when Codex needs to create a new structured doc from requirements or existing feature context, especially requests like “生成文档”, “按模板生成”, “创建 CONTEXT/SPEC/DESIGN/TEST PLAN/RELEASE NOTE”, or after starting a new feature.
---

# Doc Generator

## Overview

基于模板生成标准项目文档，并保持原框架约定的文件名、章节结构和输出位置。

## Workflow

### 1. 识别目标文档类型

根据用户请求或当前阶段识别目标文件：

- `CONTEXT` -> `10_CONTEXT.md`
- `API SPEC` -> `20_API_SPEC.md`
- `UI FLOW SPEC` -> `21_UI_FLOW_SPEC.md`
- `DESIGN` -> `40_DESIGN_FINAL.md`
- `TEST PLAN` -> `60_TEST_PLAN.md`
- `TEST REPORT` -> `61_TEST_REPORT.md`
- `RELEASE NOTE` -> `70_RELEASE_NOTE.md`
- `CHANGELOG` -> `71_CHANGELOG.md`

### 2. 定位模板源

优先在当前仓库中查找：

- `CC_COLLABORATION/03_templates/`
- `docs/_foundation/`

如果当前项目没有完整模板，但用户正在使用迁移后的框架，可回退到：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\`

### 3. 读取最小必要输入

优先复用现有上下文：

- `docs/{feature}/10_CONTEXT.md`
- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/21_UI_FLOW_SPEC.md`
- `docs/{feature}/40_DESIGN_FINAL.md`
- `docs/_foundation/`

如果模板中的关键字段无法从现有资料推断，再向用户追问最少的问题。

### 4. 按模板生成文档

要求：

- 保留章节层次和关键标题
- 保留原约定的文件名和编号
- 在有明确事实时再填写，不要伪造细节
- 必要时标出 `待确认`、`待补充`

### 5. 写入正确位置

默认输出到：

- `docs/{feature}/`
- Foundation 文档写入 `docs/_foundation/`

如果目标文件已存在：

- 默认保守处理
- 优先补全缺失章节
- 不在未获同意时整篇重写

## Template Mapping

常用模板映射：

- `01_kickoff/10_CONTEXT_TEMPLATE.md` -> `10_CONTEXT.md`
- `02_spec/20_API_SPEC_TEMPLATE.md` -> `20_API_SPEC.md`
- `02_spec/21_UI_FLOW_SPEC_TEMPLATE.md` -> `21_UI_FLOW_SPEC.md`
- `04_design/40_DESIGN_TEMPLATE.md` -> `40_DESIGN_FINAL.md`
- `06_test/60_TEST_PLAN_TEMPLATE.md` -> `60_TEST_PLAN.md`
- `06_test/61_TEST_REPORT_TEMPLATE.md` -> `61_TEST_REPORT.md`
- `07_deploy/70_RELEASE_NOTE_TEMPLATE.md` -> `70_RELEASE_NOTE.md`
- `07_deploy/71_CHANGELOG_TEMPLATE.md` -> `71_CHANGELOG.md`

## Read Only When Needed

在需要模板消费细节时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\template-consumption.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\new-feature.md`

## Do Not

- 不要脱离模板随意发明章节结构
- 不要在信息缺失时伪造接口、约束或验收标准
- 不要未经同意覆盖已有文档中的人工内容
- 不要把文档生成和代码实现混在一次输出里，除非用户明确要求