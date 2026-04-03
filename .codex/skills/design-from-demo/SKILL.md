---
name: design-from-demo
description: Extract formal API and design documents from demo artifacts, mock data, and demo review outputs. Use when Codex needs to turn a successful demo into `20_API_SPEC.md` or `40_DESIGN_FINAL.md`, especially requests like “从 Demo 反推接口”, “把 Demo 整理成正式设计”, or during the transition from Demo phase to Design phase.
---

# Design From Demo

## Overview

把 Demo 阶段已经验证过的页面、交互和 Mock 契约整理成正式设计文档，并显式标记哪些结论来自“反推”。

## Workflow

### 1. 收集 Demo 证据

优先读取：

- `docs/{feature}/demo/` 或 `docs/{feature}/_demos/`
- `docs/{feature}/demo/mock/`
- `docs/{feature}/30_DEMO_REVIEW.md`

先确认 Demo 已经足够成形；如果输入几乎为空，要直接说明无法反推。

### 2. 提取接口定义

至少提取：

- 路径
- HTTP 方法
- 请求参数
- 响应字段结构
- 错误场景

### 3. 提取数据模型与流程

尽量整理：

- 实体名称
- 字段和类型
- 关键状态流转
- 页面与接口之间的映射关系

### 4. 生成正式文档草稿

按项目需要写入或更新：

- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/40_DESIGN_FINAL.md`

要求：

- 字段名与 Demo / Mock 保持一致
- 对不确定约束加 `待确认`
- 在相关章节标注“从 Demo 反推”或 `inferred from demo`

### 5. 列出确认事项

输出时明确列出：

- 已固化的接口和模型
- 仍需人工确认的字段、约束、错误码
- 建议进入的下一步，例如设计评审或 `expert-review`

## Evidence Rule

优先依据 Demo 事实，而不是重新发明设计。若 Demo 与已有设计文档冲突，要指出冲突来源，不要静默覆盖。

## Read Only When Needed

在需要上下游规则时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\design-from-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`

## Do Not

- 不要把推断内容写成“已确认事实”而不标注来源
- 不要在 Demo 输入不足时强行补齐完整设计
- 不要覆盖已有正式设计中的人工决策而不说明冲突
- 不要忽略错误场景和边界约束