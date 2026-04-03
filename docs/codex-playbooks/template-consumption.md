# Template Consumption Playbook

## 目标

保留原框架对 `CC_COLLABORATION/03_templates` 的完整消费能力，使 Codex 在执行 `Foundation`、feature kickoff、Spec、Demo、Design、Code、Test、Deploy 等流程时，仍然能够以模板为输入源稳定地产出文档，而不是每次即兴生成。

这个 playbook 关注的不是“模板内容本身”，而是“什么时候读取模板、复制什么、允许改什么、哪些内容必须保留结构”。

## 覆盖范围

需要覆盖以下模板族：

- `00_foundation/`：项目级基础模板
- `01_kickoff/`：`10_CONTEXT.md` 模板
- `02_spec/`：`20_API_SPEC.md`、`21_UI_FLOW_SPEC.md` 模板
- `03_demo/`：`30_DEMO_REVIEW.md` 模板
- `04_design/`：`40_DESIGN_FINAL.md` 模板
- `05_code/`：`50_DEV_PLAN.md` 模板
- `06_test/`：`60_TEST_PLAN.md`、`61_TEST_REPORT.md` 模板
- `07_deploy/`：`70_RELEASE_NOTE.md`、`71_CHANGELOG.md` 模板
- `_shared/`：跨 feature 共享模板

## 输入

- 当前执行的 workflow 或 playbook 名称
- 项目路径与目标文档目录
- feature 名称
- 项目类型：`frontend`、`backend`、`fullstack`
- `feature_profile` 或等价上下文
- 是否允许覆盖已存在文档

## 输出

- 模板选择结果
- 目标文件映射表
- 已复制或已引用的模板清单
- 需要人工补充的章节提示
- 模板冲突或缺失报告

## 模板来源约定

默认模板根目录：

```text
CC_COLLABORATION/03_templates/
```

建议按以下映射消费：

| 模板目录 | 目标位置 | 使用时机 |
|---|---|---|
| `00_foundation/` | `docs/_foundation/` | `init-project` |
| `01_kickoff/10_CONTEXT_TEMPLATE.md` | `docs/{feature}/10_CONTEXT.md` | `new-feature` |
| `02_spec/20_API_SPEC_TEMPLATE.md` | `docs/{feature}/20_API_SPEC.md` | 后端或接口主导功能 |
| `02_spec/21_UI_FLOW_SPEC_TEMPLATE.md` | `docs/{feature}/21_UI_FLOW_SPEC.md` | UI 或前后端联动功能 |
| `03_demo/30_DEMO_REVIEW_TEMPLATE.md` | `docs/{feature}/30_DEMO_REVIEW.md` | Demo 评审 |
| `04_design/40_DESIGN_TEMPLATE.md` | `docs/{feature}/40_DESIGN_FINAL.md` | Design 定稿 |
| `05_code/50_DEV_PLAN_TEMPLATE.md` | `docs/{feature}/50_DEV_PLAN.md` | 开发拆解 |
| `06_test/60_TEST_PLAN_TEMPLATE.md` | `docs/{feature}/60_TEST_PLAN.md` | 测试计划 |
| `06_test/61_TEST_REPORT_TEMPLATE.md` | `docs/{feature}/61_TEST_REPORT.md` | 测试报告 |
| `07_deploy/70_RELEASE_NOTE_TEMPLATE.md` | `docs/{feature}/70_RELEASE_NOTE.md` | 发布说明 |
| `07_deploy/71_CHANGELOG_TEMPLATE.md` | `docs/{feature}/71_CHANGELOG.md` | 变更日志 |
| `_shared/*` | `docs/{feature}/` | `new-feature` 初始化时统一复制 |

## 执行步骤

### 1. 识别当前需要哪一类模板

先根据当前动作判断模板类型：

- 项目初始化：读取 `00_foundation/`
- 新功能启动：读取 `01_kickoff/` 和 `_shared/`
- 规格编写：读取 `02_spec/`
- Demo：读取 `03_demo/`
- 设计：读取 `04_design/`
- 开发计划：读取 `05_code/`
- 测试：读取 `06_test/`
- 发布：读取 `07_deploy/`

要求：
- 不要一次性把全部模板复制进上下文
- 只加载当前步骤真正需要的模板文件

### 2. 判断目标文件是否已存在

如果目标文件不存在：
- 按模板创建

如果目标文件已存在：
- 默认保守，不直接覆盖
- 优先比较“结构是否齐全”而不是“文字是否一致”
- 如需重建，必须明确记录原因

### 3. 处理 `_shared/` 模板

以下共享模板属于 feature 级公共资产：

- `01_PROJECT_PROFILE_TEMPLATE.yaml`
- `90_PROGRESS_LOG_TEMPLATE.yaml`
- `91_DAILY_SUMMARY_TEMPLATE.md`
- `PHASE_GATE_TEMPLATE.yaml`
- `PHASE_GATE_STATUS_TEMPLATE.yaml`
- `REVIEW_ACTIONS_TEMPLATE.yaml`
- `REVIEW_REPORT_TEMPLATE.md`

原则：
- `new-feature` 时统一创建
- 后续 workflow 只读写实例文件，不反复从模板覆盖
- `STATUS` 类文件优先保留运行事实，不要被模板重置

### 4. 保留模板结构，允许业务内容落地

复制模板后，允许对以下内容做业务化填写：
- 标题
- 章节内容
- 示例
- feature 名称
- 接口、页面、任务、测试条目

不应随意破坏的内容：
- 关键章节层次
- Gate 所依赖的文件名
- 与其他 playbook 约定的输出位置
- YAML 关键字段结构

### 5. 处理前后端差异

根据项目类型和 feature 特征裁剪模板：

- `frontend`：优先 `UI_FLOW_SPEC`、Demo、UI 设计模板
- `backend`：优先 `API_SPEC`、数据与接口设计模板
- `fullstack`：保留 UI + API 双侧模板
- 无 UI 功能：可跳过 `Demo` 与 `UI_FLOW_SPEC`
- 无外部接口变更：可不生成新的 API 章节，但要说明原因

### 6. 输出模板消费记录

每次完成模板消费后，建议至少记录：
- 来源模板
- 目标文件
- 是否新建
- 是否只补结构
- 是否存在手工改写
- 后续依赖的 playbook

## 核心原则

1. 模板是稳定输出的基座，不是可有可无的示例。
2. 复制模板时要保结构、保路径、保文件名约定。
3. 后续执行应修改实例文件，不反复覆盖模板。
4. 不同项目类型应消费不同模板组合，避免制造噪音文档。
5. 模板缺失时要显式报错或降级，不要静默跳过。

## 常见风险

### 1. 只复制文件，不保留结构语义

表现：
- 生成了文档，但缺少 Gate 检查依赖章节
- 生成了 YAML，但字段不完整

处理：
- 以模板结构为准补齐骨架
- 保留原字段名和关键章节标题

### 2. 重复覆盖运行中的文档

表现：
- `PHASE_GATE_STATUS.yaml` 被模板重置
- `90_PROGRESS_LOG.yaml` 历史记录丢失

处理：
- 对状态类文件默认只初始化一次
- 后续 workflow 只做增量更新

### 3. feature 类型与模板不匹配

表现：
- 纯后端功能却创建大量 UI 文档
- 纯 UI 功能却强行要求 API 模板

处理：
- 在模板选择前先读取项目类型和 feature_profile
- 无法判断时采用保守提示，而不是全量生成

## 验证清单

完成后检查：
1. 已识别当前 workflow 所需模板族
2. 已明确模板源路径与目标路径
3. 已区分初始化复制与后续增量更新
4. 已保留关键文件名、章节和 YAML 结构
5. 已给出项目类型差异下的模板裁剪规则

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\README.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\new-feature.md`
