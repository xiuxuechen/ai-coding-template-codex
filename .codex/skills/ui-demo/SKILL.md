---
name: ui-demo
description: Create lightweight interactive UI demos and prototypes from UI requirements, `21_UI_FLOW_SPEC.md`, or feature context. Use when Codex needs to show what a page or flow looks like, when the user says “做个 demo”, “生成原型”, “让我看看页面长什么样”, or during Demo phase before production implementation.
---

# UI Demo

## Overview

快速生成可查看、可交互、便于讨论的 UI Demo，用于验证设计方向，不把 Demo 伪装成生产代码。

## Workflow

### 1. 选择最合适的 Demo 形式

按以下优先级选择：

- 当前项目已有前端栈：优先沿用现有栈
- 需要快速单页展示：使用轻量 HTML
- 需要组件化状态交互：使用 React 或 Vue

默认追求最小实现成本，而不是最完整工程化。

### 2. 读取 UI 输入

优先读取：

- `docs/{feature}/21_UI_FLOW_SPEC.md`
- `docs/_foundation/_ui_system/`
- 用户给出的页面描述、草图、截图需求

至少识别：

- 页面结构
- 关键交互控件
- 主要状态
- 成功、空态、错误态

### 3. 生成 Demo

推荐输出位置：

- `docs/{feature}/_demos/`
- 或 `docs/{feature}/demo/`

要求：

- 能打开查看或简单启动
- 核心交互可演示
- 样式方向与现有 UI System 尽量一致
- 明确哪些数据是 Mock

### 4. 缺少真实后端时补 Mock

如果页面依赖接口且后端未就绪：

- 生成静态假数据
- 或调用 `$mock-api-generator` 的工作方式构造 Mock 数据与 handler

### 5. 提供查看方式

输出时说明：

- 入口文件或目录
- 直接打开还是启动开发服务器
- 已覆盖哪些状态
- 尚未覆盖哪些交互

## Demo Rules

优先覆盖：

- happy path
- 空态
- 错误态
- 加载态

如果页面很多，先生成最关键的主路径页面，再说明剩余页面计划。

## Read Only When Needed

在需要补充上下游规则时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\gen-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\design-from-demo.md`

## Do Not

- 不要把 Demo 宣称为生产级实现
- 不要为快速演示引入沉重依赖，除非项目本身已经使用
- 不要跳过关键状态展示，只做静态漂亮页面
- 不要把 Mock 数据冒充成真实接口返回