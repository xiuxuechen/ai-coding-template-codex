# UI Demo 能力说明 Playbook

## 目标

定义 `ui-demo` 这项能力在 Codex 侧的保留方式，用于根据 UI 规格或需求描述快速生成可查看、可交互的 UI Demo。

这个文档保留原 `ui_demo` skill 的核心能力：
- 根据自然语言或 UI SPEC 触发 Demo 生成
- 区分单页 HTML、React Demo、Vue Demo 等形式
- 读取 UI System 规范
- 输出可运行 Demo 与运行说明

## 输入

- 功能名称：可选
- UI SPEC 或需求描述：建议提供
- Demo 形式：可选，单页 HTML / React / Vue

## 输出

至少生成：
- 一个可直接查看的 Demo 页面
- 必要时附带样式、脚本或运行说明

建议输出目录：
- `docs/{feature}/demo/` 或 `docs/{feature}/_demos/`

## 依赖

- 来源定义：`.codex/skill-specs/ui_demo.md`
- 相关输入：`21_UI_FLOW_SPEC.md`、`docs/_foundation/_ui_system/`
- 相关能力：`mock-api-generator`
- 上游 / 下游流程：`gen-demo`、`design-from-demo`

## 执行步骤

### 1. 确定 Demo 类型

可根据上下文选择：
- 单页 HTML：快速验证单个页面
- React Demo：适合组件化或复杂交互
- Vue Demo：适合 Vue 项目或已有 Vue 语境

### 2. 读取 UI 输入

优先读取：
- `21_UI_FLOW_SPEC.md`
- UI System 设计规范
- 用户直接给出的页面描述

### 3. 生成可运行 Demo

至少包含：
- 页面布局
- 关键交互元素
- 状态表现
- 简要运行方式说明

### 4. 输出运行方式

根据 Demo 类型说明：
- 浏览器直接打开
- 或启动本地开发服务器

## 核心原则

1. Demo 优先服务于“看得见、点得动、能讨论”。
2. 优先轻量实现，避免为了 Demo 引入沉重工程负担。
3. Mock 数据和真实接口要明确区分。
4. UI Demo 只验证设计，不承诺生产代码质量。

## 文档要求

- 主要内容使用中文
- `UI Demo`、`React`、`Vue`、`HTML` 等术语可保留英文

## 验证清单

完成后检查：
1. 已确定 Demo 类型
2. 已读取足够的 UI 输入
3. 已生成可查看的 Demo
4. 已附运行说明或查看方式

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\ui_demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\gen-demo.md`
