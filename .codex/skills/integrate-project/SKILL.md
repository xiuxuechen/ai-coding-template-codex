---
name: integrate-project
description: Integrate an existing codebase into the Codex workflow by creating minimal collaboration docs, legacy context, and gate scaffolding without disrupting the running system. Use when Codex is asked to onboard a legacy repository, build migration context, or answer requests like “接入现有项目”, “把这个老项目纳入框架”, “帮我整合这个 legacy repo”, “先给这个项目搭一层协作文档”, or “执行 integrate-project”.
---

# Integrate Project

## Overview

将现有项目或现有模块渐进式纳入 Codex 框架，补齐最小协作文档骨架，同时保留 `legacy` 语义边界，避免把历史系统伪装成从零设计的新功能。

## Trigger Examples

- `接入这个现有项目`
- `把这个老项目纳入框架`
- `帮我整合这个 legacy repo`
- `执行 integrate-project，level 先保守一点`

## Workflow

### 1. 校验整合目标

优先确认：

- 项目路径
- feature 名称或模块名
- 整合级别 `Level 0-3`
- 是否已有扫描结果

如果没有扫描结果，优先先执行 `scan-project`。

### 2. 读取扫描与现状信息

至少利用：

- 技术栈摘要
- 模块划分
- API / Schema 线索
- 现有文档覆盖率
- 推荐整合级别

### 3. 建立 legacy 协作骨架

在需要时创建或补齐：

- `docs/{feature}/10_CONTEXT.md`
- `docs/{feature}/90_PROGRESS_LOG.yaml`
- `docs/{feature}/PHASE_GATE.yaml`
- `docs/{feature}/PHASE_GATE_STATUS.yaml`
- `docs/{feature}/_foundation/`

### 4. 明确 legacy 边界

要求文档中至少说明：

- 这是现有项目整合，不是全新 feature
- 哪些内容来自逆向提取
- 哪些阶段是 `retroactive`
- 哪些内容仍待补充验证

### 5. 根据整合级别给出后续动作

- `Level 0`：最小登记
- `Level 1`：建立最小协作骨架
- `Level 2`：追加 API / Schema 逆向入口
- `Level 3`：尽量接入更完整 Foundation

### 6. 输出整合结论

至少说明：

- 采用的整合级别
- 已生成文件
- 下一步建议
- 风险与未知项

## Read Only When Needed

在需要上下游规则时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\integrate-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-api.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-schema.md`

## Do Not

- 不要假装历史文档已经完整存在
- 不要把逆向结果写成原始设计事实
- 不要一次性强迫老项目补齐全部阶段文档
- 不要伪造未完成阶段的 Gate 通过状态