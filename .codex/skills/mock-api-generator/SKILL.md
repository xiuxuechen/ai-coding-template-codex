---
name: mock-api-generator
description: Generate mock API data and lightweight handlers that match the expected contract from `20_API_SPEC.md`, `21_UI_FLOW_SPEC.md`, or demo requirements. Use when Codex needs fake endpoints for demos or parallel frontend/backend work, especially requests like “生成 Mock API”, “前端先用 Mock”, “做个假接口”, or when the backend is not ready yet.
---

# Mock API Generator

## Overview

根据现有接口定义或 UI 数据需求，生成结构一致、易切换、可覆盖多场景的 Mock API 产物。

## Workflow

### 1. 确定契约来源

优先读取：

- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/21_UI_FLOW_SPEC.md`
- Demo 页面中的数据依赖
- 用户口头描述

如果契约来源不足，先列出已知字段和不确定项，不要假装完整。

### 2. 选择 Mock 形式

根据复杂度选择：

- 静态 JSON：适合纯展示和固定数据
- 本地 JS/TS handler：适合轻逻辑和多场景切换
- `msw` 或轻量 mock server：适合前端联调和 REST 行为模拟

默认选择最小可用方案。

### 3. 生成多场景 Mock

至少覆盖：

- 成功响应
- 失败响应
- 边界情况
- 空数据情况（如适用）

要求：

- 字段名与契约一致
- 类型与层级一致
- 错误码或错误消息尽量与设计一致

### 4. 选择输出位置

推荐输出到：

- `docs/{feature}/demo/mock/`
- 或当前项目已存在的 mock 目录

同时补充：

- 使用说明
- 场景切换方式
- 测试账号或测试数据

### 5. 标注切换策略

明确说明：

- 这些是 Mock 产物
- 后续切到真实接口时应替换哪些入口
- 哪些字段仍待后端确认

## Mock Quality Bar

检查以下内容：

- 请求路径和方法是否可追溯
- 响应字段是否与 SPEC 一致
- 是否覆盖至少一个错误分支
- 是否为前端保留易替换入口

## Read Only When Needed

在需要补充上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\mock-api-generator.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ui-demo.md`

## Do Not

- 不要让字段命名偏离正式契约
- 不要把 Mock 逻辑写成生产后端实现
- 不要只给 happy path，忽略失败和空态
- 不要隐瞒不确定字段或假定真实业务规则