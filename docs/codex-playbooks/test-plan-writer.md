# 测试计划生成编排 Playbook

## 目标

根据 `UI_FLOW_SPEC` 或 `API_SPEC` 自动推导测试场景、测试数据和预期结果，生成结构化的测试计划文档。

这个 playbook 保留原 `test_plan_writer` 的核心能力：
- 读取 SPEC 文档
- 分析正常流程、边界条件和异常处理
- 生成 UI / API / Unit 测试用例
- 组织测试数据
- 生成 `60_TEST_PLAN.md`

## 输入

- 功能名称：必填
- 测试类型：可选，`ui`、`api`、`unit`、`all`
- 覆盖程度：可选，`smoke`、`standard`、`full`

## 输出

生成：
- `docs/{feature}/60_TEST_PLAN.md`

必要时可附带：
- 推荐测试数据分组
- 执行优先级建议

## 依赖

- 来源定义：`CC_COLLABORATION/05_tools/subagents/test_plan_writer.md`
- 上游文档：`21_UI_FLOW_SPEC.md`、`20_API_SPEC.md`
- 相关能力：`doc-generator`
- 下游流程：`run-tests`

## 执行步骤

### 1. 读取 SPEC 文档

根据功能与测试类型，读取：
- `21_UI_FLOW_SPEC.md`
- `20_API_SPEC.md`

至少提取：
- 页面与交互
- 字段和验证规则
- API 请求与响应
- 错误场景
- 状态变化

### 2. 分析测试场景

至少覆盖：
- 正常流程
- 边界条件
- 异常处理
- 必要的安全或鉴权检查

### 3. 按覆盖程度生成测试用例

#### `smoke`
- 只覆盖核心主流程

#### `standard`
- 覆盖主流程 + 主要异常

#### `full`
- 覆盖主流程、异常、边界和更多组合场景

### 4. 组织测试类型

根据输入生成：
- UI 测试用例
- API 测试用例
- Unit 测试用例

如果某一类没有足够输入：
- 明确标注缺失原因
- 不要硬编不存在的测试基础

### 5. 生成测试计划文档

建议至少包含：
- 测试范围
- 测试类型
- 测试用例列表
- 测试数据
- 测试环境
- 优先级说明

### 6. 输出结果与下一步

至少输出：
- 计划文件路径
- 测试类型覆盖情况
- 用例数量级别
- 下一步建议，例如进入 `run-tests`

## 核心原则

1. 测试计划必须来源于 SPEC，而不是拍脑袋补充。
2. 用例优先级应帮助执行排序，而不是平均铺开。
3. 缺失输入时应显式说明，而不是伪造完整计划。
4. 测试数据应能支撑真实执行，而不是只写标题。

## 文档要求

- 主要内容使用中文
- `UI`、`API`、`Unit`、`smoke`、`standard`、`full` 等术语可保留英文
- 用例 ID、优先级和断言格式尽量保持结构化

## 验证清单

完成后检查：
1. 已读取正确的 SPEC 输入
2. 已覆盖主要测试场景
3. 已按测试类型组织测试计划
4. 已给出测试数据或数据建议
5. 已输出进入 `run-tests` 的明确建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\05_tools\subagents\test_plan_writer.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\run-tests.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\spec-writer.md`
