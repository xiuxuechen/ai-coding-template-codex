# 进入下一阶段 Playbook

## 目标

在当前阶段满足准入条件时，将功能模块推进到下一阶段，并同步更新进度状态、阶段模板和必要上下文。

这个 playbook 保留原 `/next-phase` 的核心能力：
- 读取当前阶段
- 执行 Gate 硬检查
- 识别并跳过不适用阶段
- 更新 `90_PROGRESS_LOG.yaml`
- 初始化下一阶段工作入口

## 输入

- 功能名称：必填

## 输出

至少产出：
- 当前阶段与下一阶段信息
- Gate 检查结果
- 更新后的阶段状态
- 新创建或新启用的阶段文件
- 下一步操作建议

## 依赖

- 参考命令：`.codex/commands/next-phase.md`
- 上游 playbooks：`check-gate`、`approve-gate`
- 相关文档：`90_PROGRESS_LOG.yaml`、`PHASE_GATE_STATUS.yaml`
- 后续模板来源：`CC_COLLABORATION/03_templates/`

## 执行步骤

### 1. 校验输入与功能目录

1. 功能名称不能为空。
2. 功能目录必须存在。
3. `90_PROGRESS_LOG.yaml` 必须存在，才能确定当前阶段。

### 2. 读取当前阶段

从进度日志中读取：
- 当前阶段编号
- 当前阶段状态
- checkpoint 信息

如果当前阶段已是最后阶段：
- 明确提示流程已完成
- 不再尝试推进

### 3. 执行 Gate 硬检查

这是硬规则。

只有当前阶段的 Gate 状态为：
- `passed`
- 或明确允许的 `skipped`

时，才能进入下一阶段。

如果当前阶段为：
- `pending`
- `blocked`
- 或其他未满足准入条件的状态

则必须拒绝推进，并明确说明需要先做什么。

### 4. 识别是否需要跳过阶段

如果下一阶段存在启用条件，且条件不满足：
- 允许将该阶段标记为 `skipped`
- 然后继续检查后续阶段

要求：
- 跳过必须有明确依据
- 不可随意跳过关键阶段
- 输出中必须说明跳过原因

### 5. 更新进度日志

至少更新：
- 当前阶段状态
- 下一阶段状态
- `meta.current_phase`
- `last_updated`
- `cc_checkpoint`

要求：
- 当前阶段完成后应标记为 `done`
- 下一阶段应进入 `wip` 或对应初始状态
- checkpoint 要指向清晰的下一步动作

### 6. 初始化下一阶段模板

如下一阶段需要模板文件：
- 只在文件不存在时创建
- 不覆盖已有文档
- 创建后在输出中明确列出

常见阶段文件包括：
- `20_API_SPEC.md` / `21_UI_FLOW_SPEC.md`
- `40_DESIGN_FINAL.md`
- `50_DEV_PLAN.md`
- `60_TEST_PLAN.md`
- `70_RELEASE_NOTE.md`

### 7. 输出推进结果

建议输出结构：
- 功能模块
- 前一阶段
- 当前新阶段
- 是否跳过某阶段
- 创建或更新的文件
- 下一阶段主要任务
- 下一步建议

## 核心原则

1. 未通过 Gate 时绝对不能推进。
2. 跳过阶段必须有明确规则支撑。
3. 进度更新要与阶段推进保持一致。
4. 不覆盖已有模板文件。

## 文档要求

- 主要内容使用中文
- `Phase`、`Gate`、`passed`、`skipped`、`wip` 等术语可保留英文
- 状态值尽量沿用原框架约定

## 验证清单

完成后检查：
1. 已读取当前阶段
2. 已执行 Gate 准入检查
3. 已明确拒绝或允许推进
4. 已更新进度状态
5. 已创建或确认下一阶段必要文件

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\next-phase.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\approve-gate.md`
