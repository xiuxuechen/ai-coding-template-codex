# Workflow Reference Preservation

## 目标

保留原框架在 `CC_COLLABORATION/01_workflow` 与 `CC_COLLABORATION/07_phase_gate` 中沉淀的参考知识，使 Codex 迁移后不仅保留“命令名”和“文档模板”，还保留原有方法论、阶段模型、Recipe、Phase Gate 解释和 PM Driver 认知框架。

这个文档的重点是：哪些参考资料必须仍然可达、在什么场景下应该读取、哪些内容属于方法论而不是执行结果。

## 覆盖范围

需要保留的参考目录：

- `CC_COLLABORATION/01_workflow/README.md`
- `CC_COLLABORATION/01_workflow/01_QUICKSTART.md`
- `CC_COLLABORATION/01_workflow/02_FRAMEWORK_OVERVIEW.md`
- `CC_COLLABORATION/01_workflow/03_DAILY_OPERATIONS.md`
- `CC_COLLABORATION/01_workflow/04_REFERENCE.md`
- `CC_COLLABORATION/01_workflow/05_PM_DRIVER_WORKFLOW.md`
- `CC_COLLABORATION/01_workflow/recipes/`
- `CC_COLLABORATION/07_phase_gate/README.md`

## 输入

- 当前用户任务或当前 playbook
- 所处阶段：Foundation、Kickoff、Spec、Demo、Design、Code、Test、Deploy
- 是否需要上下文恢复、并行开发、Demo、PM orchestration 等专题参考

## 输出

- 应读取的参考文档清单
- 当前任务对应的方法论提示
- 需要跳转的 Codex playbook 或 skill
- 当原框架依赖参考知识时的保守执行说明

## 参考文档分工

建议按下面方式消费参考资料：

| 参考文档 | 作用 | 典型触发时机 |
|---|---|---|
| `01_QUICKSTART.md` | 新项目上手、首次进入框架 | 首次接入仓库或解释整体流程 |
| `02_FRAMEWORK_OVERVIEW.md` | 理解 `8+1` 阶段模型、Phase 0.5、角色职责 | 解释流程设计、补全阶段认知 |
| `03_DAILY_OPERATIONS.md` | 日常开发节奏、恢复上下文、收尾动作 | `start-day`、`end-day`、`iresume` |
| `04_REFERENCE.md` | 命令、模板、约定速查 | 快速定位命令与产物 |
| `05_PM_DRIVER_WORKFLOW.md` | 项目级与功能级 PM orchestration | `ai-pm`、项目 PM、并行推进 |
| `recipes/CONTEXT_RECOVERY.md` | compact 后恢复上下文 | `iresume`、新对话接续 |
| `recipes/START_NEW_FEATURE.md` | 新 feature 启动 recipe | `new-feature` |
| `recipes/END_OF_DAY.md` | 每日结束收尾 recipe | `end-day` |
| `recipes/UI_DEMO.md` | Demo 与 Mock API 联动 recipe | `gen-demo`、`ui-demo` |
| `recipes/PARALLEL_DEVELOPMENT.md` | 多 feature 并行开发 | PM Driver 或多线并行时 |
| `07_phase_gate/README.md` | Gate 状态语义、检查/审批/推进规则 | `check-gate`、`approve-gate`、`next-phase` |

## 执行步骤

### 1. 先判断当前任务需要“执行说明”还是“方法论参考”

如果当前任务是具体执行：
- 优先进入对应的 Codex playbook
- 仅在需要补充规则时再读取 workflow reference

如果当前任务是理解框架、解释为什么这样做、恢复思路：
- 优先读取 workflow reference
- 再把结论映射到 Codex playbook

### 2. 只按场景读取最小必要参考

推荐读取策略：

- 首次上手：`README.md` + `01_QUICKSTART.md`
- 理解整体框架：`02_FRAMEWORK_OVERVIEW.md`
- 日常恢复：`03_DAILY_OPERATIONS.md` + 对应 recipe
- PM 机制：`05_PM_DRIVER_WORKFLOW.md`
- Gate 机制：`07_phase_gate/README.md`
- 专题场景：只读对应 `recipes/*.md`

要求：
- 不要默认把整套 workflow 文档全部读入上下文
- 只加载当前问题直接相关的引用材料

### 3. 保留原框架的概念词汇

以下概念在迁移后仍应保留：

- `8+1` 阶段工作流
- `Foundation Gate`
- `Phase 0.5`
- `Phase Gate`
- `Expert Review`
- `/iresume`
- `PM Driver`
- `Recipe`

允许把这些概念翻译成中文解释，但不要在 Codex 版里把它们抹平为普通步骤名，否则会丢失原框架的方法论辨识度。

### 4. 建立“参考 -> 执行”映射

建议维护以下映射关系：

- workflow reference 负责解释“为什么”和“整体规则”
- Codex playbook 负责描述“现在怎么做”
- skill 或后续脚本负责“如何更自动地做”

例如：
- `02_FRAMEWORK_OVERVIEW.md` -> `init-project.md`、`new-feature.md`、`next-phase.md`
- `03_DAILY_OPERATIONS.md` -> `start-day.md`、`end-day.md`、`iresume.md`
- `05_PM_DRIVER_WORKFLOW.md` -> `ai-pm.md`、`ai-pm-state-manager.md`
- `07_phase_gate/README.md` -> `check-gate.md`、`approve-gate.md`、`next-phase.md`

### 5. 当参考与当前实现不完全一致时，优先保留能力语义

迁移过程中可能出现：
- 原框架写的是 Codex slash command
- Codex 实际承载方式变成 playbook 或 skill

处理原则：
- 保留用户可理解的原始能力名
- 明确说明在 Codex 中的承载方式变化
- 不把“载体变化”误判成“能力缺失”

## 核心原则

1. workflow reference 是框架知识库，不应在迁移中被忽略。
2. 参考文档主要负责传递方法论和阶段语义，不直接替代执行 playbook。
3. 读取参考时遵循最小必要原则，避免上下文膨胀。
4. 原框架中的关键术语与阶段模型必须继续可追溯。
5. 当 Codex 承载方式变化时，优先保全能力和语义，再解释实现差异。

## 常见风险

### 1. 只迁移命令，不迁移解释层

表现：
- 用户知道有 `check-gate`，但不知道 Gate 为什么存在
- 用户知道有 `ai-pm`，但不理解 PM Driver 的边界

处理：
- 保留 workflow reference 的访问路径
- 在需要时从参考文档补充方法论说明

### 2. 把参考文档误当成执行脚本

表现：
- 直接照抄 Recipe 文本，不结合当前项目状态
- 把参考说明当作硬编码结果

处理：
- 参考文档只提供规则、建议和心智模型
- 真正执行仍以当前仓库事实和 playbook 为准

### 3. 迁移后术语断裂

表现：
- `Phase 0.5`、`Foundation Gate`、`Recipe` 等概念在 Codex 版消失
- 老用户无法把原经验迁移过来

处理：
- 在中文说明中保留关键英文术语
- 在相关 playbook 中显式链接参考来源

## 验证清单

完成后检查：
1. 已列出必须保留的 workflow reference 目录与文件
2. 已说明不同场景下该读取哪些参考材料
3. 已区分“方法论参考”和“执行 playbook”
4. 已保留关键术语与阶段模型
5. 已建立 reference 与 Codex playbook 的映射关系

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\01_workflow\`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\07_phase_gate\README.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\check-gate.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ai-pm.md`
