---
name: test-runner
description: Run `60_TEST_PLAN.md` test cases for UI, API, or unit coverage when a feature is ready for verification, regression testing, or release confidence checks.
---

# Test Runner

## 概述

根据 `60_TEST_PLAN.md` 执行测试用例，整理测试结果、失败级别和可回归项，为后续修复和发布提供依据。

## 工作流

### 1. 读取测试计划

优先读取：

- `docs/{feature}/60_TEST_PLAN.md`

提取：

- 用例列表
- 优先级
- 前置条件
- 断言点

### 2. 准备测试环境

按类型准备：

- `ui`：开发服务、浏览器自动化、视口
- `api`：后端服务、测试数据、请求配置
- `unit`：依赖安装、测试运行器、mock 数据

### 3. 执行测试

按计划逐条执行并记录：

- 通过 / 失败 / 跳过
- 耗时
- 失败级别（P0-P3）
- 截图、日志或错误信息

### 4. 处理失败

遵循原则：

- `P0` / `P1` 优先处理
- `P2` / `P3` 先记录再统一处理
- 不要在未确认根因前把失败当成已修复

### 5. 输出结果

输出应包含：

- 测试摘要
- 失败用例
- 严重程度分布
- 回归建议

## 按需读取

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\test-plan-writer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\test_runner.md`

## 不要

- 不要声称已执行测试，除非真的运行了
- 不要忽略失败用例的严重程度
- 不要漏记日志、截图或失败原因
- 不要把部分通过当成整体通过