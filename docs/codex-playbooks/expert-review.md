# 专家评审 Playbook

## 目标

对功能模块的关键文档或实现产物执行独立的专家评审，输出结构化问题清单和是否允许继续推进的判断。

这个 playbook 保留原 `/expert-review` 的核心能力：
- 根据阶段选择评审目标
- 构建独立第三方评审上下文
- 输出 `GO` / `REVISE` / `BLOCK` 结论
- 生成结构化评审结果文件
- 在必要时影响 External Gate 状态

## 输入

- 功能目录：必填，例如 `docs/user-auth`
- 阶段：可选
- 目标文件：可选
- 评审模型：可选
- 是否 dry run：可选

## 输出

至少产出：
- 评审结论：`GO`、`REVISE`、`BLOCK`
- 问题统计
- 结构化行动项
- 面向人的评审报告

建议输出文件：
- `{feature_path}/REVIEW_ACTIONS.yaml`
- `{feature_path}/REVIEW_REPORT.md`

## 依赖

- 参考命令：`.codex/commands/expert-review.md`
- 相关模板：`REVIEW_ACTIONS_TEMPLATE`、`REVIEW_REPORT_TEMPLATE`
- 相关能力：`expert-reviewer`、`openai_expert_review`
- 上下游 playbooks：`check-gate`、`next-phase`

## 执行步骤

### 1. 解析输入

1. 功能目录不能为空。
2. 若未指定阶段，可从进度日志推断当前阶段。
3. 若未指定目标文件，可根据阶段选择默认评审对象。

### 2. 校验评审目标

至少确认：
- 功能目录存在
- 目标文件存在
- 文件大小在可处理范围内，必要时提示拆分评审

### 3. 构建评审上下文

评审上下文应强调：
- 评审者是独立第三方
- 关注硬规则、可执行性、风险与可测试性
- 输出必须包含结构化行动项

阶段关注点可保留原框架逻辑，例如：
- Phase 1：目标清晰度、边界定义
- Phase 2：契约、错误处理、边界条件
- Phase 4：架构合理性、安全性、可测试性
- Phase 5：代码与设计一致性
- Phase 6：测试覆盖与测试有效性

### 4. 执行评审

如果是 `dry run`：
- 只展示评审输入和输出格式
- 不执行真实评审

如果是真实评审：
- 调用独立评审能力
- 保留模型、时间、目标文件等元信息
- 如果外部运行条件不满足，应明确报错，不伪造评审结果

### 5. 解析与落盘结果

至少提取并保存：
- 结论
- block 数量
- warn 数量
- 每条行动项的严重度、位置、问题、影响、修复建议、责任角色

### 6. 联动 Gate 语义

如果结论为 `BLOCK`：
- 必须明确提示 External Gate 被阻断
- 后续进入下一阶段应被视为受限

如果结论为 `REVISE`：
- 明确建议先修复后继续

如果结论为 `GO`：
- 可提示继续下一阶段，但不应跳过其他必要 Gate 检查

## 核心原则

1. 评审必须体现独立性，不能变成自我背书。
2. 每个问题都应尽量给出可执行修复建议。
3. `BLOCK` 结论要足够严肃，不能只是提醒。
4. 结构化输出是后续 Gate 判定和协作跟踪的基础。

## 文档要求

- 主要内容使用中文
- `GO`、`REVISE`、`BLOCK`、`dry run`、`External Gate` 等术语可保留英文
- 行动项字段可保留英文枚举，解释内容用中文

## 验证清单

完成后检查：
1. 已定位功能目录和目标文件
2. 已确定评审阶段或说明其来源
3. 已生成结论与问题统计
4. 已生成结构化行动项与评审报告
5. 若为 `BLOCK`，已明确说明 Gate 影响

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\expert-review.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\_shared\`
