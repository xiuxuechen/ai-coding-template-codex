# 发布说明汇总编排 Playbook

## 目标

汇总进度日志、测试报告、CHANGELOG 和功能背景信息，生成更完整的发布说明文档，并同步发布状态。

这个 playbook 保留原 `release_summarizer` 的核心能力：
- 汇总 `90_PROGRESS_LOG.yaml`
- 汇总 `61_TEST_REPORT.md`
- 汇总 CHANGELOG
- 分类新功能、改进、修复、已知问题
- 生成 `70_RELEASE_NOTE.md`
- 联动发布状态更新

## 输入

- 功能名称：必填
- 版本号：必填
- 发布类型：可选，`major`、`minor`、`patch`
- 是否包含 CHANGELOG：可选

## 输出

生成：
- `docs/{feature}/70_RELEASE_NOTE.md`

并可更新：
- `90_PROGRESS_LOG.yaml` 中的 release 信息

## 依赖

- 来源定义：`CC_COLLABORATION/05_tools/subagents/release_summarizer.md`
- 上游文档：
  - `90_PROGRESS_LOG.yaml`
  - `61_TEST_REPORT.md`
  - `*_CHANGELOG.md`
  - `10_CONTEXT.md`
- 相关能力：`doc-generator`、`progress-updater`
- 相关 playbooks：`release`、`run-tests`

## 执行步骤

### 1. 收集发布材料

至少读取：
- 功能背景与描述
- 已完成任务和阶段完成情况
- 测试结果与覆盖率
- 变更日志
- 贡献者或参与信息

### 2. 分析变更内容

建议分类为：
- 新功能
- 改进
- 修复
- 已知问题

如果来源不足：
- 明确标注缺失
- 不要虚构发布亮点

### 3. 汇总测试结果

至少汇总：
- 测试用例总数
- 通过率
- 覆盖率
- 已知失败或遗留问题

### 4. 生成发布说明

建议文档至少包含：
- 概述
- 新功能
- 改进
- 修复
- 开发统计
- 测试摘要
- 已知问题
- 升级指南
- 相关链接

### 5. 更新发布状态

在合适时更新：
- `meta.status`
- `release.version`
- `release.released_at`
- `release.release_notes`

### 6. 输出结果与下一步

至少输出：
- 发布文档路径
- 发布版本
- 测试摘要
- 已知问题数量
- 是否建议正式发布

## 核心原则

1. 发布说明应建立在真实交付证据之上。
2. 已知问题必须保留，不应为了“好看”删除。
3. 测试摘要应为发布决策提供信息，而不是装饰。
4. 发布状态更新必须与实际发布材料一致。

## 文档要求

- 主要内容使用中文
- `Release Note`、`CHANGELOG`、`minor`、`patch` 等术语可保留英文
- 统计数字和版本号保持精确

## 验证清单

完成后检查：
1. 已读取关键发布材料
2. 已完成变更分类
3. 已汇总测试结果
4. 已生成发布说明文档
5. 已更新或明确说明发布状态处理结果

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\05_tools\subagents\release_summarizer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\release.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
