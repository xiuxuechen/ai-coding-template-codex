# 断点恢复 Playbook

## 目标

基于 `90_PROGRESS_LOG.yaml` 中的 `cc_checkpoint` 和相关上下文文件，快速恢复某个功能模块的工作上下文。

这个 playbook 保留原 `/iresume` 的核心能力：
- 列出可恢复功能
- 读取进度日志
- 解析 `cc_checkpoint`
- 读取相关上下文文件
- 输出恢复摘要与下一步动作

## 输入

- 功能名称：可选，但建议提供

## 输出

至少产出：
- 当前功能模块摘要
- 当前阶段与整体进度
- 上次操作
- 下一步
- 关键上下文文件列表
- 当前任务状态

## 依赖

- 参考命令：`.codex/commands/iresume.md`
- 相关文档：`90_PROGRESS_LOG.yaml`、`10_CONTEXT.md`、设计文档、上次编辑文件

## 执行步骤

### 1. 确定功能模块

如果未指定功能：
- 扫描 `docs/` 下所有 feature
- 列出可恢复的功能模块
- 提示用户指定，或根据最近活跃项给出建议

### 2. 读取进度日志

至少读取：
- `meta`
- `stats`
- 当前阶段任务
- `cc_checkpoint`

如果进度日志不存在：
- 明确提示该功能还未初始化
- 不继续恢复流程

### 3. 解析 `cc_checkpoint`

重点提取：
- `session_id`
- `last_file_edited`
- `last_action`
- `next_step`
- `context_files`

如果 `cc_checkpoint` 缺失：
- 仍可输出基本进度
- 但要明确说明缺少断点信息

### 4. 读取相关上下文文件

优先读取：
- `10_CONTEXT.md`
- 设计文档
- `90_PROGRESS_LOG.yaml`
- 上次编辑文件

如果其中某些文件不存在：
- 跳过并说明缺失，不要中断整体恢复

### 5. 输出恢复摘要

建议输出结构：
- 基本信息
- 上次状态
- 下一步
- 相关文件
- 已完成 / 进行中 / 待开始任务

## 核心原则

1. 恢复的目标是快速重新进入上下文，而不是展示所有历史细节。
2. `next_step` 和 `last_action` 应作为恢复核心。
3. 缺文件时要降级恢复，而不是直接失败。
4. 恢复结果应服务于“现在做什么”。

## 文档要求

- 主要内容使用中文
- `session_id`、`checkpoint`、`context_files`、`wip` 等术语可保留英文

## 验证清单

完成后检查：
1. 已定位功能模块或列出候选项
2. 已读取进度日志
3. 已解析 `cc_checkpoint` 或说明缺失
4. 已输出下一步与关键上下文文件
5. 已输出当前任务状态摘要

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\iresume.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-progress.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\start-day.md`
