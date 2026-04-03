---
name: expert-review
description: Run an independent expert review workflow for a feature, phase, or target artifact and summarize GO, REVISE, or BLOCK outcomes. Use when Codex is asked to perform a third-party review, inspect delivery risk, or answer requests like “做专家评审”, “帮我独立 review 一下”, “给我一个 GO/REVISE/BLOCK 结论”, “评审这个 Phase 4 设计”, or “执行 expert-review”.
---

# Expert Review

## Overview

以独立第三方视角对功能、阶段或文档进行结构化专家评审。

## Trigger Examples

- `做一次专家评审`
- `帮我独立 review 一下这个设计`
- `给我一个 GO/REVISE/BLOCK 结论`
- `执行 expert-review，目标是 40_DESIGN_FINAL.md`

## Workflow

- 解析 feature 路径、phase、target 和可选 dry-run 等参数。
- 读取目标文档、相关 Gate 状态和必要上下文，明确评审边界。
- 从一致性、完整性、风险和可交付性角度进行独立评审。
- 输出结构化的 GO、REVISE 或 BLOCK 结论，以及可执行行动项。
- 明确评审结果对 Gate 或后续阶段的影响。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\expert-review.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-reviewer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\openai-expert-review\SKILL.md`

## Do Not

- 不要把普通 review 冒充独立第三方评审
- 不要只给结论不给依据
- 不要忽略目标 phase 的上下文
- 不要伪造 external review 已完成
- 不要把建议项写成无法执行的空话