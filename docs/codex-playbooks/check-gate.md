# Phase Gate 检查 Playbook

## 目标

检查项目或功能模块当前阶段的 `Phase Gate` 状态，明确是否满足进入下一阶段的条件。

这个 playbook 保留原 `/check-gate` 的核心能力：
- 支持 Foundation Gate 与 Feature Gate
- 读取 Gate 配置与状态文件
- 校验必需产出物
- 校验质量检查项
- 汇总审批状态
- 输出阻断原因与下一步建议

## 输入

- 功能名称：Feature Gate 模式下必填
- 阶段参数：可选，例如 `--phase=0`、`--phase=2`
- 检查范围：可选，单阶段或全阶段

## 输出

至少产出以下一种结果：
- Foundation Gate 检查结果
- 单个 Feature Phase 的 Gate 结果
- Feature 全阶段 Gate 概览

结果至少应包含：
- 当前状态
- 必需产出物检查结果
- 质量检查结果
- 审批状态
- 阻断原因
- 建议动作

## 依赖

- 参考命令：`.codex/commands/check-gate.md`
- 相关文档：`CC_COLLABORATION/07_phase_gate/`
- 相关 helper：后续可接入 `gate-checker`
- 上下游 playbooks：`approve-gate`、`next-phase`、`run-tests`

## 模式说明

### Foundation Gate

用于检查项目级基础文档和规划状态，通常对应 `Phase 0`。

### Feature Gate

用于检查单个功能在 `Phase 1-7` 中的 Gate 状态。

## 执行步骤

### 1. 解析输入

1. 当 `phase=0` 时，进入 Foundation Gate 模式。
2. 当 `phase!=0` 时，功能名称不能为空。
3. 如果既没有功能名也不是 Foundation 模式，应明确提示缺少输入。

### 2. 检查基础文件是否存在

Foundation Gate 至少检查：
- `docs/_foundation/FOUNDATION_GATE_STATUS.yaml`
- 规划文档目录及关键文件

Feature Gate 至少检查：
- `docs/{feature}/PHASE_GATE.yaml`
- `docs/{feature}/PHASE_GATE_STATUS.yaml`

如果缺失：
- 明确指出缺什么
- 给出初始化建议
- 不要继续输出伪结果

### 3. 读取配置与状态

需要读取：
- Gate 规则配置
- 当前运行状态
- 必要的 feature profile 或上下文配置

### 4. 确定检查范围

- 指定阶段时，只检查该阶段
- 未指定阶段时，可输出全部阶段概览

### 5. 执行 Gate 检查

每个阶段至少检查三类内容：
- 必需产出物
- 质量检查项
- 审批状态

输出状态建议保持以下枚举：
- `passed`
- `blocked`
- `pending`
- `skipped`
- 如有前置阶段未通过，可显示 `locked`

### 6. 输出检查结果

建议结果结构：
- 标题与检查范围
- 当前状态
- 必需产出物
- 质量检查
- 审批状态
- 阻断原因
- 建议动作

如果输出全阶段概览，应明确：
- 当前阻断点
- 待审批角色
- 下一步最重要动作

## 核心原则

1. Gate 是准入控制，不是装饰性状态展示。
2. 未通过前置条件时，不能假装当前阶段可进入。
3. 阻断原因必须足够具体，能指导下一步处理。
4. 审批状态必须与检查状态分开展示，避免混淆。

## 文档要求

- 主要内容使用中文
- `Phase Gate`、`Foundation Gate`、`Feature Gate`、`locked` 等术语可保留英文
- 状态值建议保留英文枚举，解释使用中文

## 验证清单

完成后检查：
1. 已正确区分 Foundation Gate 与 Feature Gate
2. 已读取或确认 Gate 配置与状态文件
3. 已输出至少一类 Gate 检查结果
4. 已明确阻断原因和建议动作
5. 未对缺失配置给出伪通过结果

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\07_phase_gate\README.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
