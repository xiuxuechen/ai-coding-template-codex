# 每日总结 Playbook

## 目标

汇总当天单个功能或整个项目的进展，生成一份可追溯的每日总结，用于回顾、交接和后续恢复。

这个 playbook 保留原 `/daily-summary` 的核心能力：
- 读取一个或多个 `90_PROGRESS_LOG.yaml`
- 汇总当天完成项、进行中项、阻塞项
- 生成每日总结文档
- 为日终收束与第二天恢复提供依据

## 输入

- 功能名称：可选
- 是否全局汇总：可选

## 输出

至少产出：
- 今日完成项
- 进行中项
- 阻塞项
- 明日建议
- 每日总结文档

建议输出到：
- 单功能：`docs/{feature}/91_DAILY_SUMMARY/{date}.md`
- 全局：`docs/_system/91_DAILY_SUMMARY/{date}.md`

## 依赖

- 参考命令：`.codex/commands/daily-summary.md`
- 相关文档：`90_PROGRESS_LOG.yaml`
- 上游 / 下游 playbooks：`end-day`、`start-day`

## 执行步骤

### 1. 确定汇总范围

如果指定功能：
- 只汇总该 feature

如果未指定：
- 扫描所有 feature 的进度日志
- 生成全局汇总

### 2. 读取进度日志

至少提取：
- 今日完成的 `done` 任务
- 当前 `wip` 任务
- `blocked` 任务
- 最后更新时间
- 当前阶段和完成率

### 3. 生成总结文档

建议文档结构：
- 总体进度
- 今日完成
- 进行中
- 阻塞项
- 明日计划
- 如可得，附简单燃尽数据

如果当天无更新：
- 仍应生成总结
- 明确写出“今日无更新”

### 4. 输出控制台摘要

建议摘要至少包含：
- 今日完成数
- 进行中数
- 阻塞数
- 每个 feature 的简要进度变化
- 输出文件路径

### 5. 更新关联状态

如有对应字段，可在进度日志中追加今日 summary 记录。

## 核心原则

1. 总结要忠实反映当天真实变化，不制造虚假增量。
2. 全局汇总和单功能汇总都应可读。
3. 阻塞项必须被单独拎出，不能被埋在完成项里。
4. 总结应服务于交接和第二天恢复，而不仅是存档。

## 文档要求

- 主要内容使用中文
- `done`、`wip`、`blocked`、`daily summary` 等术语可保留英文
- 日期、路径和进度变化要尽量精确

## 验证清单

完成后检查：
1. 已确定汇总范围
2. 已读取对应进度日志
3. 已汇总完成、进行中、阻塞三类信息
4. 已生成每日总结文档
5. 已输出明日计划或下一步建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\daily-summary.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\end-day.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\start-day.md`
