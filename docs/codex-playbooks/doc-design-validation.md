# Foundation 文档验证 Playbook

## 目标

对 `Foundation` 阶段的核心设计文档进行结构化验证，检查用户流程、系统责任和模块映射是否完整一致，为后续 `Foundation Gate` 提供客观验证结果。

这个 playbook 保留原 `/doc-design-validation` 的核心能力：
- 校验关键 Foundation 文档是否存在
- 逐步验证用户流程完整性
- 验证系统责任是否缺失
- 验证模块映射是否完整
- 生成 `PASS` / `FAIL` 结果
- 为 `Foundation Gate` 提供阻断依据

## 输入

- 默认执行完整验证
- 可选指定单个步骤
- 可选开启详细模式

## 输出

至少产出：
- 验证结论：`PASS` 或 `FAIL`
- FAIL / WARN 问题列表
- 建议修复动作
- 可选的详细验证过程

建议落盘到：
- `docs/_foundation/DESIGN_VALIDATION_RESULT.yaml`

## 依赖

- 参考命令：`.codex/commands/doc-design-validation.md`
- 上游 playbook：`init-project`
- 下游 playbook：`check-gate --phase=0`
- 关键输入文档：
  - `01_USER_JOURNEY.md`
  - `02_ARCHITECTURE.md`
  - `03_MODULE_DECOMPOSITION.md`

## 执行步骤

### 1. 校验必需文档

至少确认以下文档存在：
- `docs/_foundation/01_USER_JOURNEY.md`
- `docs/_foundation/02_ARCHITECTURE.md`
- `docs/_foundation/03_MODULE_DECOMPOSITION.md`

如果缺失：
- 直接输出验证失败
- 列出缺失文件
- 不继续执行后续验证

### 2. 验证用户流程完整性

重点检查：
- Happy Path 是否存在
- 步骤编号与顺序是否连续
- 每一步是否有明确下一步或结束条件
- 是否覆盖必要失败路径

### 3. 验证系统责任完整性

重点检查：
- 每个关键用户步骤是否都有对应系统责任
- 系统责任是否为空或仍是占位符
- 失败场景是否有系统处理方式

### 4. 验证模块映射完整性

重点检查：
- P0 模块是否都出现在映射关系中
- 映射表里的模块 ID 是否真实存在
- 是否存在孤立的关键模块

### 5. 验证边界一致性

重点检查：
- 用户流程中的系统边界是否与架构定义一致
- 模块职责与模块 scope 是否冲突

### 6. 生成验证结果

输出中至少区分：
- `FAIL`：阻断型问题
- `WARN`：不阻断但建议修复的问题

规则建议保持：
- 任意 `FAIL` 存在时，整体结果为 `FAIL`
- 没有 `FAIL` 时，整体结果为 `PASS`

### 7. 输出后续建议

如果结果为 `FAIL`：
- 明确指出 Foundation Gate 会被阻断
- 指导先修文档再重跑验证

如果结果为 `PASS`：
- 引导进入 `check-gate --phase=0`

## 核心原则

1. 这是“验证”，不是主观评审。
2. 结论应基于结构完整性和责任闭环，而非审美判断。
3. `FAIL` 必须能直接解释为什么阻断后续流程。
4. 验证结果要适合作为 Gate 的客观输入。

## 文档要求

- 主要内容使用中文
- `PASS`、`FAIL`、`WARN`、`Foundation Gate` 等术语可保留英文
- 问题描述要具体到步骤、章节或模块

## 验证清单

完成后检查：
1. 已检查核心 Foundation 文档存在性
2. 已输出流程、责任、模块映射三类验证结果
3. 已区分 FAIL 与 WARN
4. 已给出明确后续动作
5. 如失败，已说明会阻断 Gate

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\doc-design-validation.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
