---
name: test-plan-writer
description: Generate a structured `60_TEST_PLAN.md` from `21_UI_FLOW_SPEC.md`, `20_API_SPEC.md`, or related feature documents. Use when Codex needs to derive executable UI, API, or unit test cases before running tests, especially requests like “生成测试计划”, “根据 SPEC 出测试用例”, “补 60_TEST_PLAN”, or when a feature is ready to move from design into test preparation.
---

# Test Plan Writer

## Overview

根据 `UI_FLOW_SPEC`、`API_SPEC` 和 feature 上下文生成结构化测试计划，帮助后续 `test-runner` 真正执行测试，而不是临时拍脑袋补用例。

## Workflow

### 1. 读取测试来源

优先读取：

- `21_UI_FLOW_SPEC.md`
- `20_API_SPEC.md`
- `10_CONTEXT.md`
- 已有的 `60_TEST_PLAN.md`（如果是增量更新）

至少提取：

- 主流程
- 关键交互
- 字段校验
- API 请求与响应
- 错误场景
- 依赖与约束

### 2. 判断测试类型与覆盖等级

根据用户要求或当前 feature 状态判断：

- UI
- API
- Unit
- `smoke`
- `standard`
- `full`

如果用户没有明确说明，默认优先给出 `standard` 级别计划。

### 3. 生成测试场景

至少覆盖：

- 正常流程
- 边界条件
- 异常处理
- 必要的鉴权 / 权限判断
- 关键状态切换

如果输入不足以支撑某类测试：

- 明确指出缺失来源
- 保留可生成部分
- 不要伪造不存在的测试基础

### 4. 组织结构化测试计划

建议至少包含：

- 测试范围
- 测试类型
- 测试环境假设
- 测试数据准备
- 测试用例列表
- 优先级
- 风险说明

在可行时给出可直接复用的：

- case id
- preconditions
- steps
- expected result
- data set

### 5. 面向执行环节输出

如果用户希望落盘，目标文件通常是：

- `docs/{feature}/60_TEST_PLAN.md`

并在结尾说明：

- 哪些类型已覆盖
- 哪些类型仍缺输入
- 建议何时进入 `test-runner`

## Read Only When Needed

在需要上下游约束时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\test-plan-writer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\spec-writer.md`

## Do Not

- 不要脱离 SPEC 自行虚构需求
- 不要只给测试标题而没有可执行断言
- 不要把尚未确认的交互写成确定事实
- 不要忽略优先级与测试数据准备