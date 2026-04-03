# 发布说明 Playbook

## 目标

在满足发布条件的前提下，为指定功能模块生成发布说明，汇总功能价值、完成任务、测试结果和发布相关信息。

这个 playbook 保留原 `/release` 的核心能力：
- 校验发布参数
- 收集功能与测试信息
- 检查发布前置条件
- 生成版本化发布说明
- 更新发布状态
- 可选创建 Git Tag

## 输入

- 功能名称：必填
- 版本号：必填，建议使用语义化版本
- 是否创建 Git Tag：可选

## 输出

至少产出：
- 发布说明文档
- 发布条件检查结果
- 发布摘要
- 如适用，发布状态更新

默认建议输出到：
- `docs/{feature}/70_RELEASE_NOTES/{version}.md`

## 依赖

- 参考命令：`.codex/commands/release.md`
- 相关资料：
  - `10_CONTEXT.md`
  - `90_PROGRESS_LOG.yaml`
  - `40_TEST_REPORT.md`
  - `91_DAILY_SUMMARY/`
- 相关能力：后续可接入 `release-summarizer`

## 执行步骤

### 1. 校验输入

1. 功能名称不能为空。
2. 版本号不能为空。
3. 如果版本号不符合常见语义化版本格式，应给出提醒，但不必过度阻塞。

### 2. 收集发布信息

优先读取：
- 功能背景与目标
- 已完成任务
- 测试报告摘要
- 历史工作记录

如果部分信息缺失：
- 允许继续生成发布说明
- 但应明确标注缺失项

### 3. 检查发布条件

至少检查：
- Code 阶段是否完成
- Test 阶段是否完成或明确跳过
- 是否存在明显未完成的阻塞项

如果关键条件不满足：
- 应明确提示不建议发布
- 输出缺失原因
- 不要伪装成完整发布成功

### 4. 生成发布说明

建议文档结构：
- 概述
- 主要更新
- 完成任务
- 测试摘要
- 升级指南
- 已知问题
- 贡献者
- 相关链接

要求：
- 主要内容使用中文
- 版本号、`Release Notes`、`Git Tag`、`Semantic Versioning` 等术语可保留英文
- 信息来源不足时要显式说明，而不是填充虚构内容

### 5. 可选创建 Git Tag

如果用户确认创建 Git Tag：
- 使用明确版本号
- 输出 Tag 名称
- 如果未创建，也要在结果中说明是跳过而不是失败

### 6. 更新发布状态

如满足发布条件并完成发布文档生成，可更新：
- `Phase 7` 状态
- `meta.status`
- release 元数据

### 7. 输出发布结果

建议输出结构：
- 功能模块
- 版本号
- 发布日期
- 发布说明路径
- 测试摘要
- Git Tag 状态
- 下一步建议

## 核心原则

1. 发布说明不是营销文案，而是交付记录。
2. 不满足关键发布条件时，不应伪装成正式发布成功。
3. 信息来源要尽量可追溯到功能文档和测试结果。
4. Tag 创建是可选动作，不应与文档生成耦死。

## 文档要求

- 主要内容使用中文
- `Release Notes`、`Git Tag`、`Semantic Versioning` 等术语可保留英文
- 版本和路径信息保持精确

## 验证清单

完成后检查：
1. 已校验功能与版本输入
2. 已收集核心发布信息
3. 已检查关键发布前置条件
4. 已生成发布说明文档
5. 已说明 Git Tag 与发布状态处理结果

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\release.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`
