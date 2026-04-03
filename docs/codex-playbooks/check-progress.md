# 进度查看 Playbook

## 目标

查看单个功能模块或整个项目的进度状态，帮助快速判断当前阶段、任务分布和下一步里程碑。

这个 playbook 保留原 `/check-progress` 的核心能力：
- 支持单功能详细视图
- 支持全局概览视图
- 读取 `90_PROGRESS_LOG.yaml`
- 展示阶段状态、任务统计和下一里程碑

## 输入

- 功能名称：可选

## 输出

至少产出以下之一：
- 单功能详细进度视图
- 全局功能概览

结果至少应包含：
- 当前阶段
- 状态
- 任务统计
- 下一里程碑

## 依赖

- 参考命令：`.codex/commands/check-progress.md`
- 相关文档：`90_PROGRESS_LOG.yaml`
- 相关 playbooks：`iresume`

## 执行步骤

### 1. 确定范围

如果指定功能：
- 读取该功能的 `90_PROGRESS_LOG.yaml`
- 输出详细视图

如果未指定：
- 扫描所有存在进度日志的 feature
- 输出全局概览

### 2. 读取进度日志

重点提取：
- `meta`
- `stats`
- 当前阶段任务
- `cc_checkpoint.next_step`
- 各阶段状态

### 3. 生成视图

#### 单功能视图

建议包含：
- 基本信息
- 进度条或完成率
- 各阶段状态
- 当前阶段任务列表
- 下一里程碑

#### 全局视图

建议包含：
- 所有活跃功能
- 当前阶段
- 总体完成率
- 下一步
- 活跃 / 完成 / 阻塞统计

### 4. 输出建议动作

单功能视图可提示：
- 继续当前任务
- 使用 `iresume` 恢复上下文

全局视图可提示：
- 查看某个具体 feature 的详情
- 从最活跃或最阻塞项开始处理

## 核心原则

1. 进度展示应帮助决策，而不是堆砌原始 YAML。
2. 单功能和全局视图要区分目的。
3. 进度百分比只是摘要，任务状态才是行动依据。
4. 缺少进度日志时应直接指出，而不是给空结果。

## 文档要求

- 主要内容使用中文
- `wip`、`pending`、`blocked`、`completion_rate` 等术语可保留英文

## 验证清单

完成后检查：
1. 已确定输出范围
2. 已读取至少一份进度日志
3. 已输出阶段状态与任务统计
4. 已输出下一里程碑或下一步建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\check-progress.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\iresume.md`
