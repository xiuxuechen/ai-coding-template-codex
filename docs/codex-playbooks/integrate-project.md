# 现有项目整合 Playbook

## 目标

将一个现有项目纳入 `ai-coding-template` 的协作体系，在不破坏原有业务运行的前提下，建立最小可维护的单一信息来源。

这个 playbook 保留原 `/integrate-project` 的核心能力：
- 调用扫描结果作为输入
- 按整合级别生成文档骨架
- 建立 `Context`、`Progress Log`、`Phase Gate` 等基础文件
- 给历史功能打上 `legacy` 语义边界

## 输入

- 项目路径：必填
- 整合级别：可选，默认 `Level 1`
- 手动模式：可选
- 模块名称：可选，默认使用项目名或扫描结果中的名称

## 输出

在目标工作区创建或补齐：

```text
docs/{feature-name}/
├── 10_CONTEXT.md
├── 90_PROGRESS_LOG.yaml
├── PHASE_GATE.yaml
├── PHASE_GATE_STATUS.yaml
└── _foundation/
    └── .gitkeep
```

根据整合级别，补充：
- 技术决策说明
- API / Schema 逆向任务入口
- `legacy` 状态说明

## 依赖

- 前置 playbook：`scan-project`
- 参考命令：`.codex/commands/integrate-project.md`
- 后续 playbooks：`reverse-api`、`reverse-schema`、`sync-docs`
- 模板来源：`CC_COLLABORATION/03_templates/`

## 整合级别

### Level 0

仅完成最小登记：
- 建立极简 `10_CONTEXT.md`
- 记录项目路径、技术栈、项目状态
- 标记为 `legacy`

### Level 1

建立 AI 可协作的最小骨架：
- 模块划分
- 技术栈摘要
- 进度日志
- Gate 状态初始化
- `_foundation/` 目录

### Level 2

支持更深的协作：
- 在 Level 1 基础上，补充 API 与数据模型逆向入口
- 为后续 `reverse-api`、`reverse-schema` 做准备

### Level 3

作为重点项目深度接入：
- 尽可能接入完整 Foundation
- 增加更完整的文档、约束与后续治理计划

## 执行步骤

### 1. 解析输入

1. 校验项目路径。
2. 校验 `Level` 范围必须在 `0-3`。
3. 如果未提供模块名称，优先从扫描结果或项目配置推断。

### 2. 获取扫描结果

如果没有现成结果，先执行 `scan-project`。

扫描结果至少应提供：
- 技术栈
- 模块数
- 文档覆盖情况
- 推荐整合级别

### 3. 创建整合目录与基础文件

在 `docs/{feature-name}/` 下准备：
- `10_CONTEXT.md`
- `90_PROGRESS_LOG.yaml`
- `PHASE_GATE.yaml`
- `PHASE_GATE_STATUS.yaml`
- `_foundation/.gitkeep`

### 4. 生成 `10_CONTEXT.md`

要求：
- 明确这是“现有项目整合”而不是全新功能
- 对历史能力加上 `legacy` 语义边界
- 说明哪些内容来自逆向提取，必要时标记 `[逆向]`
- 说明新功能以后应继续遵循标准 Phase 流程

### 5. 生成 `PHASE_GATE_STATUS.yaml`

要求：
- 记录整合时间、整合级别
- 对已追溯视为完成的阶段做 `retroactive` 标记
- 明确哪些阶段仍为 `pending`
- 禁止伪造未完成阶段的通过状态

### 6. 生成 `90_PROGRESS_LOG.yaml`

要求：
- 保留整合记录
- 记录扫描摘要
- 初始化 `cc_checkpoint`
- 明确下一步，例如补 Foundation、逆向 API、逆向 Schema

### 7. 对 Level 2 及以上增加深度整合入口

当 `Level >= 2` 时，明确提示后续动作：
1. 逆向 API 文档
2. 逆向 Schema 文档
3. 同步文档与代码关系

### 8. 输出整合结论

输出中至少应包含：
- 整合目标项目
- 实际采用的 `Level`
- 已生成文件
- 后续建议动作
- 风险提示

## 核心原则

1. 不破坏现有项目的正常运行。
2. 不强制一次性补齐全部历史文档。
3. 新增能力和未来改造遵循框架规范。
4. 对逆向得到的内容要允许不完整，并标出来源。

## 文档要求

- 主要内容使用中文
- `legacy`、`Level`、`Phase Gate`、`playbook` 等词可保留英文
- 输出要强调“渐进式整合”，不要给人一种必须一次做完的压力

## 验证清单

完成后检查：
1. 已存在 `docs/{feature-name}/10_CONTEXT.md`
2. 已存在 `docs/{feature-name}/90_PROGRESS_LOG.yaml`
3. 已存在 `docs/{feature-name}/PHASE_GATE_STATUS.yaml`
4. `10_CONTEXT.md` 已说明整合级别和 `legacy` 身份
5. `90_PROGRESS_LOG.yaml` 已包含整合记录与下一步建议
6. 输出中已说明后续是否建议执行 `reverse-api` 或 `reverse-schema`

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\integrate-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\08_legacy_integration\`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\scan-project.md`
