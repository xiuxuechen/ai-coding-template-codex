---
name: gen-demo
description: Generate lightweight demo artifacts for a feature, including UI flow scaffolding and mock-backed interactions, before production implementation. Use when Codex is asked to make a demo or answer requests like “生成 Demo”, “先做个演示版”, “帮我出一个可交互的页面示意”, “给这个功能快速做个展示版”, or “执行 gen-demo”.
---

# Gen Demo

## Overview

为功能快速生成轻量级 Demo，用于验证交互和需求理解。

## Trigger Examples

- `生成这个功能的 Demo`
- `先做个演示版`
- `帮我出一个可交互的页面示意`
- `执行 gen-demo，先用 mock 数据`

## Workflow

- 确认 feature、Demo 目标和演示边界。
- 读取 CONTEXT、UI 流程、Mock 约束或现有设计输入。
- 生成 Demo 页面、演示说明或入口骨架。
- 标注 Demo 使用的假数据和未进入正式实现的部分。
- 输出 Demo 产物位置以及后续转正式设计的建议。

## Read Only When Needed

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\gen-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\gen-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ui-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\ui-demo\SKILL.md`

## Do Not

- 不要把 Demo 当生产实现
- 不要隐藏假数据或 Mock 边界
- 不要跳过输入文档就直接生成空壳
- 不要把视觉演示误说成真实业务已完成
- 不要省略后续正式设计入口