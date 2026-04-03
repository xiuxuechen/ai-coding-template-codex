---
name: openai-expert-review
description: Run an external OpenAI-powered reviewer adapter when the task needs to execute a structured expert review through the OpenAI API, especially after `expert-review` or when a review prompt has already been prepared and Codex only needs to call the model, handle retries, and return the raw response. Use when the task is about invoking the review runner rather than defining the review rubric itself.
---

# OpenAI Expert Review

## Overview

这是 Expert Reviewer 的执行器（runner / adapter）。它负责调用 OpenAI API，返回原始评审结果，不负责定义评审规则或解释业务结论。

## Workflow

### 1. 确认输入已准备好

先确认上游已经提供：

- review prompt
- model 或默认模型
- temperature / max_tokens（如有）
- 期望的输出格式

如果输入不完整，先补齐调用参数，不要自行补写评审规则。

### 2. 检查运行前置条件

至少检查：

- `OPENAI_API_KEY`
- 模型名称是否可用
- 超时 / 重试配置是否存在

### 3. 执行 API 调用

通过 OpenAI API 发起请求，并处理：

- timeout
- retry
- rate limit
- network error

### 4. 返回原始结果

优先返回：

- success / error
- content
- usage
- 原始响应里可用的结构化信息

不要在这个 skill 里自行把结果解释成最终裁决；那应由上游 expert-review 逻辑或评审规则定义层处理。

## Read Only When Needed

在需要更完整的上下文时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\openai_expert_review.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-reviewer.md`

## Do Not

- 不要定义 GO / REVISE / BLOCK 这类评审规则
- 不要把模型返回的原始内容伪装成已经解析好的业务结论
- 不要在没有 API Key 或模型配置时假装执行成功
- 不要把这个 skill 当成评审策略本身