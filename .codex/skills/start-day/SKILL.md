---
name: start-day
description: Start the day by syncing the repository, restoring the most relevant feature context, and surfacing today's next actions. Use when Codex is asked to begin work for the day, resume current development, restore the latest checkpoint, or answer requests like “开始今天工作”, “执行 start-day”, “恢复今天要做的功能”, or “看看今天先做什么”.
---

# Start Day

## Overview

在开始当天工作时，先完成代码同步判断、功能定位、上下文恢复和待办提取，再进入具体实现。

## Workflow

### 1. 判断是否需要 Git 同步

如果当前目录是 Git 仓库：

- 先查看当前分支与工作区状态
- 如适合安全同步，再执行 `git pull origin <当前分支>` 或等效同步动作
- 如果出现冲突，立即停止后续恢复流程，并明确提示先解决冲突

如果不是 Git 仓库：

- 说明已跳过 Git 同步
- 继续恢复上下文

### 2. 确定今日功能模块

如果用户明确给了 feature 名称，直接使用。

如果没有明确给出：

- 扫描 `docs/` 下的 feature 目录
- 优先读取各目录中的 `90_PROGRESS_LOG.yaml`
- 根据 `last_updated`、`wip`、`next_step`、`cc_checkpoint` 判断最近最值得恢复的功能
- 如果候选项超过一个，先给出排序依据，再请用户选择或先展示全局概览

### 3. 恢复上下文

优先读取：

- `docs/<feature>/90_PROGRESS_LOG.yaml`
- `docs/<feature>/10_CONTEXT.md`
- `docs/<feature>/40_DESIGN_FINAL.md`
- `cc_checkpoint.context_files` 中记录的关键文件

需要时补充读取：

- `docs/<feature>/20_API_SPEC.md`
- `docs/<feature>/21_UI_FLOW_SPEC.md`
- 最近编辑的代码文件

输出时至少说明：

- 当前 feature
- 当前 phase 或阶段
- 上次操作
- 下一步
- 关键上下文文件

### 4. 提取今日待办

优先整理：

- `wip` 任务
- `next_step`
- 高优先级 `pending` 任务
- 已知阻塞项

不要随机编造任务，也不要把长期 backlog 当作今日首要动作。

### 5. 输出开始工作摘要

最终摘要至少包含：

- Git 同步结果或跳过原因
- 当前 feature
- 当前阶段与整体进度
- 上次操作
- 今日待办
- 第一优先动作

## Read Only When Needed

在需要更完整流程或输出格式时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\start-day.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\iresume.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\start-day.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-progress.md`

## Do Not

- 不要假装已经执行了 `git pull`
- 不要在检测到冲突后继续推进业务工作
- 不要在没有证据时臆造 feature 状态
- 不要忽略 `wip` 和 `next_step`
- 不要把这个 skill 误说成 CLI 原生 slash command 菜单项