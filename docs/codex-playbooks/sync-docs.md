# 文档同步检查 Playbook

## 目标

检查文档与代码之间是否仍然一致，及时发现 API、数据模型、模块划分等方面的偏差，并给出同步建议。

这个 playbook 保留原 `/sync-docs` 的核心能力：
- 定位文档与代码的对应关系
- 检查 API 文档一致性
- 检查数据模型文档一致性
- 检查模块划分一致性
- 生成同步报告和修复建议

## 输入

- 功能目录或项目路径：必填
- 检查类型：可选，支持 `all`、`api`、`schema`、`modules`
- 是否启用修复模式：可选
- 是否使用严格模式：可选

## 输出

至少产出一份同步检查结果，建议包含：
- 总体同步状态
- API 差异
- Schema 差异
- 模块差异
- 建议动作

如需要落盘，可保存为同步报告文件。

## 依赖

- 参考命令：`.codex/commands/sync-docs.md`
- 前置文档可能包括：
  - `10_CONTEXT.md`
  - `20_API_SPEC.md`
  - `_foundation/03_DATA_MODEL.md`
- 相关 playbooks：`reverse-api`、`reverse-schema`、`integrate-project`
- 可复用 skill：后续可接入 `review-alignment`

## 执行步骤

### 1. 定位文档与代码路径

需要尽量确定：
- 功能目录位置
- 原始项目代码路径
- 待比较的文档文件

如果无法定位代码路径：
- 明确报出阻塞原因
- 提示用户补充路径
- 不要继续做伪检查

### 2. 检查 API 文档一致性

如果存在 API 文档：
- 对比文档中的端点与代码中的路由定义
- 找出新增、移除、变更、不一致项

差异分类建议统一为：
- `added`
- `removed`
- `modified`
- `matched`

### 3. 检查数据模型一致性

如果存在数据模型文档：
- 对比模型名、字段名、字段类型、关系定义
- 找出新增字段、删除字段、类型变更、关系变更

### 4. 检查模块划分一致性

如果有模块划分说明：
- 对比文档中的模块与实际目录结构
- 找出新增目录、消失目录、描述失真模块

### 5. 生成同步报告

建议报告结构：
- 总体状态
- API 差异详情
- 数据模型差异详情
- 模块差异详情
- 建议操作
- 如启用修复模式，附自动修复结果

### 6. 可选修复模式

如果启用修复模式：
- 只自动处理低风险、格式化明确的项目
- 在修改前备份原文档
- 在自动修复处增加明确标记

不建议自动修复的情况：
- 复杂响应结构变化
- 业务语义变化
- 关系含义不明确的 Schema 变化

## 核心原则

1. 默认以只读检查为主。
2. 差异报告要能帮助人快速决策，而不是堆砌噪音。
3. 自动修复必须是保守的、可回溯的。
4. 检查不应伪装成“完全同步”，不确定时应明确说明。

## 文档要求

- 主要内容使用中文
- `API`、`Schema`、`modules`、`strict` 等术语可保留英文
- 差异分类可使用英文枚举值，解释部分用中文

## 验证清单

完成后检查：
1. 已定位文档与代码的对应关系
2. 已给出至少一种差异检查结果
3. 已输出建议动作
4. 如果使用修复模式，已说明修改范围和备份策略
5. 阻塞信息足够明确，便于人工继续

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\sync-docs.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-api.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\reverse-schema.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\integrate-project.md`
