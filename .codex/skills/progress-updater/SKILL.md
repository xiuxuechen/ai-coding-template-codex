---
name: progress-updater
description: Update `90_PROGRESS_LOG.yaml`, task status, and checkpoint data for a feature. Use when Codex needs to record progress, resume work, or sync status for `/check-progress`, `/daily-summary`, or `/iresume`.
---

# Progress Updater

## Overview

维护功能模块的 `90_PROGRESS_LOG.yaml`，同步任务状态、断点信息和统计数据，保证进度记录可恢复、可追踪。

## Workflow

### 1. 定位目标文件

读取：

- `docs/{feature}/90_PROGRESS_LOG.yaml`

必要时联读：

- 当前 feature 的上下文文档
- 相关测试或门禁状态

### 2. 执行指定动作

常见动作：

- 更新任务状态 `pending / wip / done`
- 更新 `cc_checkpoint`
- 更新统计信息

### 3. 保持状态一致

确保：

- 同一时间只有一个任务处于 `wip`
- `done` 任务带有完成时间
- 断点信息能支持后续恢复

### 4. 更新时间戳

写回时同步更新 `meta.last_updated`。

### 5. 输出变更摘要

说明：

- 改了哪个任务
- 断点更新了什么
- 完成率如何变化

## Read When Needed

在需要更完整流程时读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-progress.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\daily-summary.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\iresume.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skill-specs\progress_updater.md`

## Do Not

- 不要修改无关文档
- 不要同时制造多个 `wip`
- 不要丢失已有 checkpoint
- 不要在没有依据时重置统计数据