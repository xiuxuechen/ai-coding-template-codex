---
name: run-tests
description: Execute relevant tests for a feature or the whole project, collect results, and summarize failures, coverage, and next actions. Use when Codex is asked to run tests, verify a feature, produce a test report, or answer requests like “执行 run-tests”, “帮我跑一下测试”, “验证这个 feature”, or “输出测试结果和结论”.
---

# Run Tests

## Overview

按 feature 或项目范围执行测试，收集结果并产出可追踪的测试摘要。

## Workflow

- 确定测试范围是单个 feature 还是全量项目。
- 定位测试文件、测试命令和相关运行环境。
- 执行测试并收集通过数、失败项、错误日志和可用覆盖率信息。
- 整理失败原因、影响范围和推荐下一步。
- 必要时联动测试报告产物，但不要伪造通过结果。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\run-tests.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\test-runner\SKILL.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\test-report-generator\SKILL.md`

## Do Not

- 不要在未执行时声称测试已通过
- 不要忽略失败日志和退出码
- 不要把 dry-run 结果包装成真实执行结果
- 不要遗漏测试范围说明
- 不要在未经确认时删除或修改测试文件