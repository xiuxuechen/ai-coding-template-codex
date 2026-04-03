---
name: sync-docs
description: Check documentation against code for APIs, schemas, and modules, then summarize drift and optionally propose safe fixes. Use when Codex is asked to verify design-code alignment or answer requests like “同步文档”, “检查文档和代码是否一致”, “看看接口文档有没有过期”, “帮我找出 doc drift”, or “执行 sync-docs”.
---

# Sync Docs

## Overview

检查代码与文档之间的偏差，生成可决策的差异报告，并在低风险情况下支持保守修复，避免文档长期漂移失真。

## Trigger Examples

- `检查文档和代码是否一致`
- `看看接口文档有没有过期`
- `帮我找出 doc drift`
- `执行 sync-docs，先只看 API`

## Workflow

### 1. 定位文档与代码对应关系

优先确定：

- feature 目录
- 原始代码路径
- API 文档位置
- 数据模型文档位置
- 模块说明位置

### 2. 检查 API 一致性

如存在 API 文档，比较：

- 端点列表
- 请求参数
- 响应结构
- 鉴权要求

### 3. 检查 Schema 一致性

如存在数据模型文档，比较：

- 模型名
- 字段名与类型
- 约束
- 关系定义

### 4. 检查模块划分一致性

如存在模块说明，比较：

- 模块名称
- 目录结构
- 责任描述是否明显失真

### 5. 输出同步报告

至少说明：

- matched
- added
- removed
- modified
- 建议动作

如启用修复模式，只处理低风险、结构明确的改动。

## Read Only When Needed

在需要上下游规则时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\sync-docs.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-api.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-schema.md`

## Do Not

- 不要在找不到代码路径时假装做完检查
- 不要把复杂语义变化自动修复掉
- 不要隐藏差异或失败检查结果
- 不要把“不确定一致”写成“完全同步”