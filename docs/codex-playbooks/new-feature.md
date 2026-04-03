# 新功能启动 Playbook

## 目标

为一个新的功能模块建立可持续协作的最小骨架，确保后续可以进入 `Spec`、`Demo`、`Code`、`Test` 等阶段。

这个 playbook 保留原 `/new-feature` 的核心能力：
- 创建功能目录
- 生成 `10_CONTEXT.md`
- 生成 `90_PROGRESS_LOG.yaml`
- 创建 `_demos/` 目录
- 为后续 Phase 流程提供入口

## 输入

- 功能名称：必填，建议使用 kebab-case，例如 `user-auth`
- 功能描述：可选，建议提供 1 到 3 句业务描述
- 负责人：可选
- 目标用户：可选

## 输出

在 `docs/{feature-name}/` 下生成或更新：

```text
docs/{feature-name}/
├── 10_CONTEXT.md
├── 90_PROGRESS_LOG.yaml
└── _demos/
    └── .gitkeep
```

## 依赖

- 模板来源：`CC_COLLABORATION/03_templates/01_kickoff/`
- 相关 skills：后续可接入 `doc-generator`
- 后续流程：`spec-writer`、`gen-demo`、`run-tests`

## 执行步骤

### 1. 校验输入

1. 功能名称不能为空。
2. 功能名称优先使用小写字母、数字、连字符。
3. 如果目录已存在，先读取已有文档，再决定是补全还是覆盖，避免破坏已有内容。

### 2. 创建功能目录

创建：
- `docs/{feature-name}/`
- `docs/{feature-name}/_demos/`
- `docs/{feature-name}/_demos/.gitkeep`

### 3. 生成 `10_CONTEXT.md`

分两种模式：

#### 智能模式

当用户提供了功能描述时，优先从描述中提取：
- 核心功能点
- 目标用户
- 业务价值
- 关键约束
- In Scope / Out of Scope

然后组织成中文结构化文档，至少包含：
- 功能背景
- 目标
- 预期价值
- 功能范围
- 目标用户
- 核心场景
- 依赖与集成
- 里程碑

#### 模板模式

当用户没有提供足够描述时，按模板生成待补全文档，保留明确占位文本，如：
- `{请补充}`
- `{请描述功能背景和解决的问题}`

### 4. 生成 `90_PROGRESS_LOG.yaml`

至少包含：
- `meta`
- `phase_1_kickoff`
- `phase_2_spec`
- 基本 `cc_checkpoint`

要求：
- `phase_1_kickoff` 初始状态为 `wip`
- 已完成任务应记录创建目录和初始化文件
- 下一步应明确指向补全 `10_CONTEXT.md` 或进入 `Spec`

### 5. 给出下一步建议

完成后，给出 1 到 3 条明确下一步，例如：
1. 补全 `10_CONTEXT.md`
2. 基于 CONTEXT 生成 SPEC
3. 如需演示界面，进入 Demo 流程

## 文档要求

- 主要内容使用中文
- 专有名词可保留英文，例如 `skills`、`playbook`、`Spec`、`Demo`
- 文件路径、字段名、阶段名保持原框架风格

## 验证清单

完成后检查：
1. `docs/{feature-name}/10_CONTEXT.md` 已存在
2. `docs/{feature-name}/90_PROGRESS_LOG.yaml` 已存在
3. `docs/{feature-name}/_demos/.gitkeep` 已存在
4. `10_CONTEXT.md` 至少包含“目标”和“功能范围”章节
5. `90_PROGRESS_LOG.yaml` 至少包含 `meta` 和 `phase_1_kickoff`

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\new-feature.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\01_kickoff\`
