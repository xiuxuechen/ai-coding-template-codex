# Gate 审批 Playbook

## 目标

为指定功能模块的指定阶段执行 Gate 审批，在满足检查条件的前提下记录审批结果，并在所有必需角色完成审批后将 Gate 推进到可通过状态。

这个 playbook 保留原 `/approve-gate` 的核心能力：
- 校验审批参数
- 校验功能与 Gate 文件存在性
- 校验审批角色是否合法
- 先检查后审批
- 记录审批轨迹
- 在满足条件时更新 Gate 状态

## 输入

- 功能名称：必填
- 阶段：必填
- 审批角色：必填
- 审批人：可选，默认可记为人工审批

## 输出

至少产出：
- 审批记录结果
- 当前审批状态
- Gate 当前状态
- 如审批被拒绝，给出明确阻断原因与修复建议

## 依赖

- 参考命令：`.codex/commands/approve-gate.md`
- 上游 playbook：`check-gate`
- 下游 playbook：`next-phase`
- 相关 helper：后续可接入 `gate-checker`

## 执行步骤

### 1. 校验输入

1. 功能名称不能为空。
2. 阶段不能为空。
3. 审批角色不能为空。
4. 如果任一关键参数缺失，应直接返回正确用法，不做模糊猜测。

### 2. 校验 Gate 文件

至少确认以下文件存在：
- `docs/{feature}/PHASE_GATE.yaml`
- `docs/{feature}/PHASE_GATE_STATUS.yaml`

如果缺失：
- 明确指出缺失项
- 提示先初始化功能或 Gate 配置
- 不继续审批流程

### 3. 校验审批角色

读取阶段配置中要求的审批角色列表。

如果指定角色不在审批列表中：
- 明确拒绝审批
- 展示当前阶段允许的角色
- 不写入任何状态变更

### 4. 先检查后审批

这是硬规则。

在审批前，必须先确认当前阶段不存在未通过的 block 级检查项。

要求：
- 如果存在 block 级失败，审批必须被拒绝
- 输出中必须列出关键失败项
- 引导用户先执行 `check-gate` 或先修复问题

### 5. 记录审批

当检查通过且角色合法时：
- 为对应角色写入审批人
- 写入审批时间
- 保留审计痕迹

如果该角色已审批：
- 不重复写入冲突记录
- 应明确提示该角色已完成审批

### 6. 判断是否可通过 Gate

只有当以下条件同时满足时，当前阶段 Gate 才能进入通过状态：
- block 级检查全部通过
- 所有必需审批角色均已完成审批

如果尚未全部审批完成：
- Gate 应保持 `pending`
- 输出中列出仍待审批的角色

### 7. 输出结果

建议输出结构：
- 功能模块
- 当前阶段
- 审批角色与审批人
- 已完成审批列表
- 未完成审批列表
- Gate 状态
- 下一步建议

## 核心原则

1. 审批不能绕过质量检查。
2. 审批记录必须可追溯。
3. 审批状态与 Gate 状态要分开展示。
4. 只有满足全部条件时，才允许把 Gate 推到 `passed`。

## 文档要求

- 主要内容使用中文
- `Gate`、`passed`、`pending`、`block` 等术语可保留英文
- 角色名如 `PM`、`Architect` 可保留英文

## 验证清单

完成后检查：
1. 已校验功能目录与 Gate 文件存在性
2. 已校验审批角色是否合法
3. 已执行“先检查后审批”逻辑
4. 已记录或拒绝审批并说明原因
5. 如仍待其他角色审批，已明确列出

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\approve-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\next-phase.md`
