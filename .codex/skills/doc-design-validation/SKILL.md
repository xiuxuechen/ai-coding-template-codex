---
name: doc-design-validation
description: Validate foundation design documents by simulating flows, system responsibilities, and consistency, then report PASS, FAIL, or WARN evidence. Use when Codex is asked to validate phase-0 documents, stress-test the design, or answer requests like “验证 Foundation 设计”, “检查这些基础文档有没有断层”, “帮我跑一次文档设计验证”, “看看 Foundation 文档是否自洽”, or “执行 doc-design-validation”.
---

# Doc Design Validation

## Overview

用客观验证而不是主观评审的方式检查 Foundation 设计文档是否自洽、完整、可执行。

## Trigger Examples

- `验证 Foundation 设计`
- `检查这些基础文档有没有断层`
- `帮我跑一次文档设计验证`
- `执行 doc-design-validation，给我 PASS/FAIL/WARN`

## Workflow

- 定位 `_foundation` 下的核心设计文档，并明确验证范围。
- 按用户流程、系统责任和状态变迁逐步模拟，查找断裂、矛盾和缺失。
- 输出 PASS、FAIL、WARN 级别的验证结论，而不是泛泛评论。
- 标明每个问题对应的文档位置、影响和建议修复方向。
- 总结是否满足 Foundation Gate 的设计验证要求。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\doc-design-validation.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\doc-design-validation.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\system-scaffolder\SKILL.md`

## Do Not

- 不要把验证写成主观评审
- 不要只说感觉不合理却不给证据
- 不要忽略用户流程和系统状态的衔接
- 不要把 WARN 夸大成 FAIL
- 不要修改文档事实来掩盖问题