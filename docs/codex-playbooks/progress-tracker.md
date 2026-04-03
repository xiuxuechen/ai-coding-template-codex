# 进度跟踪汇总编排 Playbook

## 目标

基于一个或多个 `90_PROGRESS_LOG.yaml` 自动生成结构化的每日进展总结，并在需要时同步 checkpoint 信息，作为 `daily-summary` 的编排层补充。

这个文档保留原 `progress_tracker` 的核心能力：
- 支持单功能与全局汇总
- 读取进度日志并筛选当日任务
- 汇总完成、进行中、新增任务
- 生成每日总结文档
- 在合适时联动更新 checkpoint

## 输入

- 日期：可选，默认当天
- 功能名称：可选
- 模式：`single`、`global`、`auto`

## 输出

按模式生成：
- 单功能：`docs/{feature}/91_DAILY_SUMMARY/{date}.md`
- 全局：`docs/_daily_summary/{date}.md` 或等效全局摘要

## 依赖

- 来源定义：`CC_COLLABORATION/05_tools/subagents/progress_tracker.md`
- 上游输入：一个或多个 `90_PROGRESS_LOG.yaml`
- 相关能力：`doc-generator`、`progress-updater`
- 相关 playbooks：`daily-summary`、`end-day`

## 执行步骤

### 1. 确定汇总范围

根据输入判断：
- `single`：只汇总一个 feature
- `global`：汇总所有活跃 feature
- `auto`：有 feature 时走单功能，否则走全局

### 2. 读取进度日志

至少提取：
- 当日完成任务
- 当前 `wip` 任务
- 当日新增任务
- 完成率
- 相关负责人或当前阶段

### 3. 计算统计信息

建议统计：
- 完成数
- 进行中数
- 新增数
- 完成率
- 如果可得，可估算时间投入或进展增量

### 4. 生成总结文档

单功能摘要建议包含：
- 今日概览
- 已完成
- 进行中
- 明日计划
- 风险与问题

全局摘要建议包含：
- 各功能今日完成项
- 活跃功能数
- 平均完成率
- 阻塞或风险功能

### 5. 更新 checkpoint 或摘要记录

如工作流需要，可在进度日志中记录：
- 本次生成时间
- 下一步
- summary 关联路径

### 6. 输出结果

至少输出：
- 生成文档路径
- 今日统计摘要
- 明日重点项

## 核心原则

1. 汇总必须忠实于进度日志，不能虚构工作量。
2. 单功能和全局模式的目标不同，输出粒度也应不同。
3. 汇总结果应帮助第二天恢复与团队同步，而不是只做存档。
4. 如果当天没有更新，也应明确输出“无更新”结论。

## 文档要求

- 主要内容使用中文
- `single`、`global`、`checkpoint`、`wip` 等术语可保留英文

## 验证清单

完成后检查：
1. 已正确判定汇总模式
2. 已读取对应进度日志
3. 已计算基础统计信息
4. 已生成总结文档
5. 已给出下一步或明日重点

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\05_tools\subagents\progress_tracker.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\daily-summary.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\end-day.md`
