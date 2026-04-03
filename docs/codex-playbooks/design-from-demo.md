# 从 Demo 提炼设计 Playbook

## 目标

在 Demo 评审通过后，从 UI Demo、Mock API 和评审记录中提炼出正式设计文档，作为从 `Phase 3 Demo` 进入 `Phase 4 Design` 的桥梁。

这个文档保留原 `design_from_demo` skill 的核心能力：
- 收集 Demo 产出物
- 从 Mock 中提取接口定义
- 从 Mock 与展示数据中提取数据模型
- 生成正式 API / Design 文档
- 明确标注来源为“从 Demo 反推”

## 输入

- 功能名称：必填
- Demo 目录：默认从功能目录推断
- 是否只提取部分接口：可选

## 输出

按场景生成或更新：
- `docs/{feature}/20_API_SPEC.md`
- `docs/{feature}/40_DESIGN_FINAL.md`

并应在文档中明确标注：
- 来源于 Demo 反推
- 仍需人工确认

## 依赖

- 来源定义：`.codex/skill-specs/design_from_demo.md`
- 上游输入：
  - `docs/{feature}/demo/`
  - `docs/{feature}/demo/mock/`
  - `30_DEMO_REVIEW.md`
- 相关能力：`mock-api-generator`、`doc-generator`
- 下游流程：`expert-review`、`next-phase`

## 执行步骤

### 1. 收集 Demo 产出物

优先读取：
- UI Demo 页面
- Mock API 数据与 handler
- Demo 评审记录

### 2. 提取接口定义

至少提取：
- 路径
- HTTP 方法
- 请求参数
- 响应结构
- 错误码或错误场景

### 3. 提取数据模型

尽量提取：
- 实体名称
- 字段列表
- 字段类型
- 基本关系线索

### 4. 生成正式设计文档

根据项目性质生成：
- `20_API_SPEC.md`
- `40_DESIGN_FINAL.md`

要求：
- 字段名与 Mock 保持一致
- 对来源明确标记“从 Demo 反推”
- 对不确定部分保留待确认提示

### 5. 输出结果与后续建议

至少输出：
- 生成或更新的文档
- 提取到的接口数量或模型数量
- 需要人工确认的重点项
- 下一步建议，例如进入 `expert-review`

## 核心原则

1. 反推设计要忠实于 Demo 和 Mock 事实。
2. 反推结果必须标明来源，避免误认为天然就是正式设计。
3. 不确定的字段约束或业务语义要显式标注。
4. 从 Demo 到正式设计是“固化”，不是“重新发明”。

## 文档要求

- 主要内容使用中文
- `Demo`、`Mock API`、`API SPEC`、`Design` 等术语可保留英文
- 来源说明和待确认标记要足够醒目

## 验证清单

完成后检查：
1. 已读取 Demo 与 Mock 输入
2. 已提取接口定义或数据模型
3. 已生成正式设计文档草稿
4. 已标明“从 Demo 反推”来源
5. 已给出人工确认与后续评审建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\design_from_demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\gen-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\expert-review.md`
