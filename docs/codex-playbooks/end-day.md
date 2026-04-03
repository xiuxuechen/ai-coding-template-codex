# 每日结束 Playbook

## 目标

在一天工作结束前收拢进度、更新断点、生成总结，并完成必要的代码提交与推送决策，让第二天能够顺畅恢复。

这个 playbook 保留原 `/end-day` 的核心能力：
- 更新 `90_PROGRESS_LOG.yaml`
- 维护 `cc_checkpoint`
- 生成每日总结
- 检查 Git 变更
- 组织 commit 与可选 push

## 输入

- 功能名称：可选
- 是否快速模式：可选
- 是否推送远程：需明确确认

## 输出

至少产出：
- 当日已完成任务清单
- 更新后的 `90_PROGRESS_LOG.yaml`
- 每日总结文件
- Git 状态与 commit 结果
- 明日第一步建议

## 依赖

- 参考命令：`.codex/commands/end-day.md`
- 下游 playbooks：`daily-summary`
- 相关文档：`90_PROGRESS_LOG.yaml`

## 执行步骤

### 1. 确定处理范围

如果指定功能：
- 只处理该功能

如果未指定：
- 优先处理当天有变更或处于活跃状态的功能模块

### 2. 更新进度日志

至少完成：
- 核对当前 `wip` 任务
- 记录今天完成的任务
- 保留未完成的 `wip` 或更新为新的 `wip`
- 更新 `meta.last_updated`
- 更新 `stats`

要求：
- 尽量保证同一时间只有一个主 `wip` 焦点
- 不要自动把未完成任务误标为 `done`

### 3. 更新 `cc_checkpoint`

至少记录：
- 本次 session 标识
- 最后编辑文件
- 最后动作
- 明日第一步
- 关键上下文文件

### 4. 生成每日总结

调用 `daily-summary` 或等效逻辑，产出今天的总结文档。

### 5. 检查 Git 状态

至少查看：
- 修改文件
- 新增文件
- 未提交内容

### 6. 组织 commit 与 push

如存在变更：
- 组织合适的 commit 信息
- 完成 `git add` 和 `git commit`
- push 必须由用户明确确认，除非进入明确允许的快速模式

如果没有变更：
- 明确说明今天没有需要提交的内容

### 7. 输出日终摘要

建议输出结构：
- 今日完成
- 仍在进行中
- 总体进度变化
- 生成的文档
- Git 提交结果
- 明日计划

## 核心原则

1. 日终流程的核心是为第二天恢复上下文做准备。
2. 进度更新必须忠实反映真实完成情况。
3. push 属于外部动作，默认需要确认。
4. 每日总结和 checkpoint 应互相印证，而不是各写各的。

## 文档要求

- 主要内容使用中文
- `Git`、`commit`、`push`、`wip`、`checkpoint` 等术语可保留英文

## 验证清单

完成后检查：
1. 已更新进度日志
2. 已更新 `cc_checkpoint`
3. 已生成每日总结
4. 已检查 Git 状态并说明提交结果
5. 已给出明日第一步建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\end-day.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\daily-summary.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\iresume.md`
