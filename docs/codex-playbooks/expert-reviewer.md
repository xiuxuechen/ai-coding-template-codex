# 独立专家评审编排 Playbook

## 目标

作为 `expert-review` 的编排层，负责构建独立第三方评审上下文、委托外部 Runner 执行评审，并将结果整理成可用于 Gate 与协作的结构化输出。

这个文档保留原 `expert_reviewer` 的核心能力：
- 定义评审规则与输出契约
- 读取目标文档与相关上下文
- 构建评审 Prompt
- 委托外部 Runner 执行
- 解析响应并生成 `REVIEW_ACTIONS.yaml` 与 `REVIEW_REPORT.md`
- 在 `BLOCK` 时触发 External Gate 语义

## 输入

- 功能路径：必填
- 评审阶段：可选
- 目标文件：可选
- dry run：可选

## 输出

生成：
- `docs/{feature}/REVIEW_ACTIONS.yaml`
- `docs/{feature}/REVIEW_REPORT.md`

并至少产出：
- verdict：`GO`、`REVISE`、`BLOCK`
- 问题统计
- 结构化行动项

## 依赖

- 来源定义：`CC_COLLABORATION/05_tools/subagents/expert_reviewer.md`
- 外部 Runner：`openai_expert_review` 或等效能力
- 相关 playbooks：`expert-review`、`check-gate`
- 相关模板：评审报告与评审动作模板

## 执行步骤

### 1. 校验输入与目标文件

至少确认：
- 功能目录存在
- 目标文件存在
- 若未指定阶段，则能从进度日志推断阶段

### 2. 构建评审上下文

评审上下文必须强调：
- 第三方独立性
- 可执行修复建议
- 硬规则优先
- 输出必须符合结构化格式

### 3. 委托 Runner 执行

在非 dry run 模式下：
- 调用 Runner 执行实际评审
- 保留模型、时间和目标文件信息

在 dry run 模式下：
- 仅展示 Prompt 与输出契约
- 不进行真实调用

### 4. 解析响应

至少校验：
- `verdict`
- `summary`
- `actions`

如果解析失败：
- 保留原始输出
- 明确报错
- 不写入伪结构化结果

### 5. 生成输出文件

`REVIEW_ACTIONS.yaml` 应作为权威结构化结果。

`REVIEW_REPORT.md` 应作为人类可读摘要。

### 6. 处理 Gate 语义

如果 `verdict = BLOCK`：
- 必须明确 External Gate 被阻断
- 后续推进阶段应受限

## 核心原则

1. 评审必须独立，不能沦为自证正确。
2. 结构化输出是后续自动化判定的基础。
3. 任何 `BLOCK` 都必须足够具体，便于修复。
4. Runner 与编排层职责要分离，避免把 API 调用细节污染进业务判定。

## 文档要求

- 主要内容使用中文
- `GO`、`REVISE`、`BLOCK`、`Runner`、`External Gate` 等术语可保留英文

## 验证清单

完成后检查：
1. 已定位目标文件和阶段
2. 已构建独立评审上下文
3. 已生成结构化行动项与评审报告
4. 已明确 verdict 及其影响
5. 若为 `BLOCK`，已说明 Gate 限制

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\05_tools\subagents\expert_reviewer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
