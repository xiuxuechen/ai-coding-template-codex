# 功能规划清单 Playbook

## 目标

从 `Foundation` 阶段的模块拆分文档中解析出功能开发顺序清单，为后续按顺序执行 `new-feature` 提供单一信息来源。

这个 playbook 保留原 `/plan-features` 的核心能力：
- 读取模块拆分表格
- 对字段进行强校验
- 解析依赖关系
- 检测循环依赖
- 生成开发批次与顺序清单
- 输出 `FEATURE_CHECKLIST.md`

## 输入

- 默认从 `docs/_foundation/03_MODULE_DECOMPOSITION.md` 读取
- 可选启用严格模式

## 输出

至少产出：
- 模块解析摘要
- 依赖分析结果
- 开发批次划分
- 功能开发顺序清单

默认建议输出到：
- `docs/_foundation/FEATURE_CHECKLIST.md`

## 依赖

- 参考命令：`.codex/commands/plan-features.md`
- 上游 playbooks：`init-project`、`doc-design-validation`、`check-gate --phase=0`
- 下游 playbook：`new-feature`

## 执行步骤

### 1. 校验前置条件

至少确认以下文件存在：
- `docs/_foundation/03_MODULE_DECOMPOSITION.md`
- `docs/_foundation/04_ROADMAP.md`
- `docs/_foundation/02_ARCHITECTURE.md`

如果缺失：
- 说明 Foundation 还未准备完成
- 不生成清单

### 2. 解析模块表

只解析：
- `## 2. 功能模块列表` 章节下的第一张 Markdown 表格

至少提取字段：
- `module_id`
- `feature_name`
- `模块名称`
- `描述`
- `scope`
- `deliverable`
- `acceptance`
- `priority`
- `depends_on`
- `risk`
- `owner`

### 3. 执行字段强校验

重点校验：
- `module_id` 格式
- `feature_name` 必须是 kebab-case
- `priority` 值是否合法
- `depends_on` 格式是否合法
- 必填字段是否为空

如果使用严格模式：
- 任一校验失败都应中止生成

### 4. 分析依赖关系

至少执行：
- 引用有效性检查
- 循环依赖检测
- 拓扑排序

输出结果应包含：
- Batch 1、Batch 2、Batch 3 ...
- 每个模块依赖谁
- 哪些模块现在可开始

### 5. 生成开发顺序清单

建议清单至少包含：
- 批次分组
- 模块顺序
- `feature_name`
- 优先级
- 当前状态
- 当前应做的下一项

如果已有 feature 目录存在：
- 允许在清单中体现其已开始或已完成状态
- 不要重复建议用户创建已存在的 feature

### 6. 输出下一步建议

至少建议：
- 查看 `FEATURE_CHECKLIST.md`
- 从当前应做的 feature 开始执行 `new-feature`
- 按顺序推进，而不是无节制并行

## 核心原则

1. 唯一数据源是模块拆分表，不从别处拼凑。
2. 清单的作用是帮助单线程推进，而不是制造更多并行混乱。
3. 依赖关系必须可靠，不能在有循环依赖时继续生成误导性结果。
4. 状态判断应尽量贴近真实 feature 目录与进度情况。

## 文档要求

- 主要内容使用中文
- `kebab-case`、`Batch`、`feature_name`、`priority` 等术语可保留英文
- 表格字段名尽量沿用原框架定义

## 验证清单

完成后检查：
1. 已读取正确的数据源章节和表格
2. 已完成字段校验
3. 已完成依赖分析与循环检测
4. 已生成 `FEATURE_CHECKLIST.md` 或明确说明失败原因
5. 已给出最优先的下一步 feature 建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\plan-features.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\new-feature.md`
