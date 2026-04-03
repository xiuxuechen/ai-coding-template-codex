# SPEC 生成编排 Playbook

## 目标

根据 `10_CONTEXT.md` 中定义的需求、边界和用户故事，生成可进入后续评审与 Demo 阶段的 SPEC 文档。

这个 playbook 保留原 `spec_writer` 的核心能力：
- 读取 `10_CONTEXT.md`
- 判断应生成 `UI_FLOW_SPEC`、`API_SPEC` 或两者
- 组织 SPEC 框架与详细内容
- 触发 SPEC 完整性验证
- 记录 SPEC 变更轨迹

## 输入

- 功能名称：必填
- SPEC 类型：可选，`ui`、`api`、`both`
- 详细程度：可选，`basic`、`standard`、`detailed`

## 输出

按功能类型生成以下一个或多个文件：
- `docs/{feature}/21_UI_FLOW_SPEC.md`
- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/11_SPEC_CHANGELOG.md`

## 依赖

- 来源定义：`CC_COLLABORATION/05_tools/subagents/spec_writer.md`
- 上游文档：`10_CONTEXT.md`
- 相关能力：`doc-generator`、`spec-validator`、`changelog-updater`
- 下游流程：`gen-demo`、`design-from-demo`、`expert-review`

## 执行步骤

### 1. 读取 CONTEXT

至少提取：
- 功能概述
- 用户故事
- 功能边界
- 关键约束
- 目标用户

如果 `10_CONTEXT.md` 缺失或仍主要是占位内容：
- 不进入自动生成
- 先提示补全文档

### 2. 判断 SPEC 类型

可根据用户指定或 CONTEXT 自动判断：
- `ui`：有页面、表单、交互流程
- `api`：有接口、服务、数据交换需求
- `both`：前后端都需要规格定义

### 3. 生成 SPEC 骨架

优先通过 `doc-generator` 或等效模板生成方式创建框架。

要求：
- 不要直接写成空壳标题
- 至少带出主要章节
- 文档结构要适配 `ui` 或 `api` 类型

### 4. 填充详细内容

#### UI SPEC

至少补充：
- 页面清单
- 页面详情
- 字段定义
- 交互规则
- 状态定义
- 错误处理
- 公共组件或复用块

#### API SPEC

至少补充：
- 端点清单
- 请求参数
- 请求体结构
- 响应结构
- 错误码与错误处理
- 鉴权与权限要求

### 5. 执行 SPEC 验证

通过 `spec-validator` 或等效规则检查：
- 用户故事是否被覆盖
- 关键字段和交互是否完整
- 错误场景是否缺失
- 是否仍有明显占位符

### 6. 记录变更

生成或更新 `11_SPEC_CHANGELOG.md`，至少记录：
- 新增文档
- 主要范围
- 版本或日期
- 变更说明

### 7. 输出结果与下一步

至少输出：
- 已生成的 SPEC 文件
- 文档类型
- 验证结果
- 下一步建议，例如进入 Demo 或评审

## 核心原则

1. SPEC 必须覆盖 CONTEXT 中的关键用户故事。
2. 自动生成不等于可以跳过人工评审。
3. `ui` 和 `api` 两类规格要各自完整，不要混写得模糊不清。
4. 变更必须留痕，便于后续协作与追踪。

## 文档要求

- 主要内容使用中文
- `SPEC`、`UI Flow`、`API`、`state`、`props` 等术语可保留英文
- 表格字段和文件名尽量沿用原框架风格

## 验证清单

完成后检查：
1. 已读取并理解 `10_CONTEXT.md`
2. 已正确判断或确认 SPEC 类型
3. 已生成至少一份有效 SPEC 文档
4. 已执行完整性校验或明确说明校验阻塞
5. 已记录变更日志与下一步建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\05_tools\subagents\spec_writer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\new-feature.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
