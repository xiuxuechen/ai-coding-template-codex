---
name: spec-validator
description: Validate `20_API_SPEC.md` and `21_UI_FLOW_SPEC.md` for completeness and consistency when a feature spec is ready for gate review, demo work, or downstream implementation.
---

# Spec Validator

## 概述

检查 `20_API_SPEC.md` 和 `21_UI_FLOW_SPEC.md` 的完整性、一致性和可执行性，确保规格足够稳定，可以进入实现、Demo 或 Phase Gate 验证。

## 工作流

### 1. 识别检查范围

优先判断：

- 只检查 `UI` 规格
- 只检查 `API` 规格
- 同时检查 `UI` 和 `API`
- 是否需要与 `10_CONTEXT.md` 交叉验证

### 2. 读取必要文档

默认读取：

- `docs/{feature}/10_CONTEXT.md`
- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/21_UI_FLOW_SPEC.md`

只在需要时再读取相关 playbook 或模板。

### 3. 执行完整性检查

重点检查：

- 页面或端点是否覆盖完整
- 字段、参数、响应是否定义清楚
- 状态、错误码、校验规则是否缺失
- 交互流程和依赖关系是否一致
- CONTEXT 中提到的关键需求是否在 SPEC 中体现

### 4. 标记问题等级

建议保持以下语义：

- `ERROR`：必须修复
- `WARNING`：建议修复
- `INFO`：可选优化

### 5. 生成验证结论

输出应包含：

- 摘要
- 问题列表
- 修复建议
- 下一步动作

如果 STRICT 模式开启，`WARNING` 也要纳入不通过判断。

## 按需读取

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\spec-writer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\doc-design-validation.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\spec_validator.md`

## 不要

- 不要把推断内容写成已确认事实
- 不要忽略 CONTEXT 中已经明确的需求
- 不要省略文件位置或关键依据
- 不要在验证失败时直接跳过问题列表