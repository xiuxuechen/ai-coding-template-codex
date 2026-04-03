# 每日开始 Playbook

## 目标

在开始当天工作时完成代码同步、功能定位、上下文恢复和待办提取，让协作从清晰上下文而不是零散记忆开始。

这个 playbook 保留原 `/start-day` 的核心能力：
- 可选执行 Git 同步
- 自动或手动确定今日要处理的功能模块
- 调用 `iresume` 恢复上下文
- 提取今日待办
- 输出开始工作的统一摘要

## 输入

- 功能名称：可选
- 是否执行 Git 同步：可选
- 是否查看全局概览：可选

## 输出

至少产出：
- Git 同步结果或跳过原因
- 今日处理的功能模块
- 上下文恢复摘要
- 今日待办清单
- 明确的第一步动作

## 依赖

- 参考命令：`.codex/commands/start-day.md`
- 下游 playbooks：`iresume`、`check-progress`
- 相关文档：`90_PROGRESS_LOG.yaml`

## 执行步骤

### 1. 同步代码状态

如果当前目录是 Git 仓库：
- 可执行 `git pull` 或等效同步动作
- 记录当前分支
- 如果有冲突，应立即停止后续恢复流程并提示先解决冲突

如果不是 Git 仓库：
- 明确说明跳过同步
- 继续后续步骤

### 2. 确定今日功能模块

如果用户指定了功能：
- 直接进入该功能的恢复流程

如果未指定：
- 扫描 `docs/` 目录下的功能模块
- 读取各自的 `90_PROGRESS_LOG.yaml`
- 按最近更新时间或进行中状态推断优先项

如果存在多个候选：
- 输出候选项和排序依据
- 允许用户选择或先查看全局进度

### 3. 恢复上下文

调用 `iresume` 或等效恢复流程，读取：
- 当前阶段
- 上次操作
- 下一步
- 关键上下文文件

### 4. 提取今日待办

优先列出：
- `wip` 任务
- 当日应优先完成的 `pending` 任务
- 阻塞项（如有）

### 5. 输出开始摘要

建议输出结构：
- Git 同步结果
- 当前功能模块
- 当前阶段与整体进度
- 上次操作
- 今日待办
- 第一优先动作

## 核心原则

1. 先恢复上下文，再开始执行。
2. Git 冲突优先处理，不能带着冲突进入业务工作。
3. 今日待办应优先基于 `wip` 和 `next_step`，不是随机挑任务。
4. 如果信息不完整，也要明确告诉用户“缺了什么”。

## 文档要求

- 主要内容使用中文
- `Git`、`wip`、`next_step`、`session` 等术语可保留英文

## 验证清单

完成后检查：
1. 已判断是否需要进行 Git 同步
2. 已定位今日功能模块或列出候选项
3. 已恢复至少一份上下文摘要
4. 已输出今日待办和第一步动作

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\start-day.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\iresume.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-progress.md`
