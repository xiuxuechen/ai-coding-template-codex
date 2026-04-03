---
name: review-alignment
description: Compare implementation against design docs and interface contracts after coding, especially `40_DESIGN_FINAL.md`, `20_API_SPEC.md`, and `21_UI_FLOW_SPEC.md`. Use when Codex needs to review whether a completed feature matches the documented design, when the user says “检查代码和设计是否一致”, “review 实现”, or after finishing a feature before testing or delivery.
---

# Review Alignment

## Overview

对照设计文档、接口文档和实现代码，输出“哪里一致、哪里偏差、偏差风险是什么”。

## Workflow

### 1. 定位文档与代码范围

优先定位：

- `docs/{feature}/40_DESIGN_FINAL.md`
- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/21_UI_FLOW_SPEC.md`
- 对应的实现目录、路由、服务、模型、组件

如果 feature 名称不明确，先根据用户当前改动或文档目录推断。

### 2. 提取设计要点

至少提取以下对照对象：

- API 路径、方法、参数、响应结构
- 模型字段名、字段类型、约束
- 错误处理与状态码
- 关键交互流程
- 安全、性能或边界条件约束

### 3. 扫描实现事实

只依据当前仓库事实检查：

- 路由与控制器
- 数据模型或 schema
- 返回对象与错误处理
- 前端页面流程与交互状态

### 4. 输出 findings-first 报告

优先输出：

- 严重不一致项
- 中等风险差异项
- 缺失实现项
- 明显与设计一致的关键项

如果没有发现问题，要明确说明“未发现一致性问题”，并补充剩余风险或未验证范围。

### 5. 在需要时落盘

如果用户希望保留结果，可将差异整理到：

- `REVIEW_ACTIONS.yaml`
- `REVIEW_REPORT.md`

## Comparison Checklist

重点检查：

- API 路径与方法是否一致
- 请求参数与类型是否一致
- 响应结构、字段名、状态码是否一致
- 模型字段命名和类型是否一致
- 关键业务流程和异常路径是否落实
- 设计中声明的限制条件是否真的实现

## Read Only When Needed

在需要更完整的流程说明时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\sync-docs.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`

## Do Not

- 不要在没有设计文档的情况下假装完成对齐检查
- 不要把“文档过时”的情况误写成“代码有 bug”而不说明前提
- 不要未经用户要求直接改代码；先给出差异和建议
- 不要只给结论，不给证据位置