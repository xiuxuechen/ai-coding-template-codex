---
name: test-report-generator
description: Summarize test execution results into `61_TEST_REPORT.md` when a feature needs a structured test report for review, release, or handoff.
---

# Test Report Generator

## 概述

汇总测试执行结果，生成结构化的 `61_TEST_REPORT.md`，让测试结论、失败分析和覆盖情况可以被 review、release 或后续修复直接使用。

## 工作流

### 1. 收集测试结果

优先来源：

- `test-runner` 的执行结果
- 最近一次测试缓存
- 用户提供的测试日志或结果对象

### 2. 分析覆盖情况

整理：

- 用例覆盖范围
- 功能覆盖范围
- 失败集中点
- 是否存在未覆盖的关键路径

### 3. 生成报告内容

报告应至少包含：

- 执行摘要
- 测试结果明细
- 失败用例分析
- 覆盖分析
- 问题汇总
- 修复优先级

### 4. 保持结果真实

只能基于已有测试结果写报告，不要把未运行的测试写成已通过。

## 按需读取

在需要上下游流程时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\release-summarizer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\test_report_generator.md`

## 不要

- 不要伪造测试结果
- 不要遗漏失败用例
- 不要在没有数据来源时补写覆盖率
- 不要把草稿当成正式报告