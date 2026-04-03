# Mock API 生成能力说明 Playbook

## 目标

定义 `mock-api-generator` 这项能力在 Codex 侧的保留方式，用于在 Demo 阶段或前后端并行阶段快速生成符合接口预期的 Mock 数据与 Mock 逻辑。

这个文档保留原 `mock_api_generator` skill 的核心能力：
- 从 API SPEC、UI SPEC 或口头描述提取数据需求
- 选择合适的 Mock 方式
- 生成结构一致的 Mock 数据
- 支持成功、失败和边界场景

## 输入

- 功能名称：可选
- 接口定义来源：`20_API_SPEC.md`、`21_UI_FLOW_SPEC.md` 或用户描述
- Mock 方式：可选，JSON / JS Mock / Mock Server

## 输出

建议输出目录：
- `docs/{feature}/demo/mock/`

至少产出：
- Mock 数据文件
- 必要的处理逻辑
- 简单使用说明

## 依赖

- 来源定义：`.codex/skill-specs/mock_api_generator.md`
- 上游文档：`20_API_SPEC.md`、`21_UI_FLOW_SPEC.md`
- 相关能力：`ui-demo`、`design-from-demo`

## 执行步骤

### 1. 确定 Mock 范围

至少识别：
- 路径
- 方法
- 请求参数
- 响应结构
- 错误场景

### 2. 选择 Mock 方式

根据复杂度选择：
- JSON 文件：适合静态场景
- JS Mock：适合简单逻辑
- Mock Server：适合需要 REST 行为的场景

### 3. 生成 Mock 数据

要求：
- 字段名与文档保持一致
- 至少覆盖成功与失败场景
- 边界情况尽量补齐

### 4. 输出使用方式

说明：
- 测试账号或测试数据
- 如何切换场景
- 如何与 Demo 结合使用

## 核心原则

1. Mock 字段必须与正式接口预期一致。
2. Mock 是过渡手段，但不能造成后续切换真实接口的额外破坏。
3. 要明确哪些内容是 Mock，不能让使用者误以为是真实后端。
4. Mock 范围应贴近 Demo 或当前验证目标，不宜过度扩张。

## 文档要求

- 主要内容使用中文
- `Mock API`、`JSON`、`Mock Server` 等术语可保留英文

## 验证清单

完成后检查：
1. 已确定接口定义来源
2. 已选择合适的 Mock 方式
3. 已生成成功 / 失败至少两类数据
4. 已说明使用方式和限制

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\mock_api_generator.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\gen-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\design-from-demo.md`
