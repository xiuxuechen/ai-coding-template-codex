# Foundation 初始化 Playbook

## 目标

为项目初始化 `Foundation` 文档体系，建立 `docs/_foundation/` 目录和基础模板，使项目后续能够进入 `Foundation Gate` 检查与功能拆解流程。

这个 playbook 保留原 `/init-project` 的核心能力：
- 校验当前目录是否为项目根目录
- 根据项目类型创建 `Foundation` 目录结构
- 从模板复制规划与规范文档
- 初始化 `FOUNDATION_GATE_STATUS.yaml`
- 给出后续填写与检查指引

## 输入

- 项目根目录：默认当前目录
- 项目类型：必填，可为 `frontend`、`backend`、`fullstack`
- 是否允许覆盖已存在 Foundation：可选

## 输出

至少创建或补齐：

```text
docs/_foundation/
├── _planning/
├── _db_system/      (backend/fullstack)
├── _api_system/     (backend/fullstack)
├── _ui_system/      (frontend/fullstack)
└── FOUNDATION_GATE_STATUS.yaml
```

## 依赖

- 参考命令：`.codex/commands/init-project.md`
- 模板来源：`CC_COLLABORATION/03_templates/00_foundation/`
- 下游 playbooks：`doc-design-validation`、`check-gate`、`plan-features`

## 执行步骤

### 1. 校验项目根目录

至少满足以下任一条件：
- 存在 `package.json`
- 存在 `.git` 目录

如果不满足：
- 明确提示当前目录不适合作为项目根目录
- 不继续初始化

### 2. 检查是否已初始化

如果 `docs/_foundation/` 已存在：
- 展示现有结构
- 默认保守处理，不直接覆盖
- 只有在用户明确允许时才执行覆盖或重建

### 3. 确定项目类型

根据用户输入或现有项目特征确定：
- `frontend`
- `backend`
- `fullstack`

要求：
- 类型不同，复制的模板集合不同
- 不要为纯前端项目生成无意义的后端规范目录

### 4. 复制 Foundation 模板

所有项目都应复制：
- `_planning/`

其中 `_planning/` 至少应包含：
- `01_USER_JOURNEY.md`
- `02_ARCHITECTURE.md`
- `03_MODULE_DECOMPOSITION.md`
- `04_ROADMAP.md`
- `05_TECH_DECISIONS.md`
- `06_CODE_STANDARDS.md`
- `07_EXECUTION_PERMISSION_POLICY.md`

`backend` / `fullstack` 还应复制：
- `_db_system/`
- `_api_system/`

`frontend` / `fullstack` 还应复制：
- `_ui_system/`

要求：
- 模板文件只在目标不存在或允许覆盖时写入
- 复制后目录结构要清晰可读

### 5. 初始化 `FOUNDATION_GATE_STATUS.yaml`

至少记录：
- 项目类型
- 初始化时间
- Gate 初始状态
- 关键文档存在性
- 审批状态占位

默认状态建议为：
- `pending`

### 6. 输出结果与下一步建议

至少说明：
- 创建了哪些目录和文件
- 哪些文档需要手动填写
- 下一步先做什么

建议后续顺序：
1. 完成 `_planning/` 文档，尤其 `06_CODE_STANDARDS.md` 与 `07_EXECUTION_PERMISSION_POLICY.md`
2. 运行 `doc-design-validation`
3. 运行 `check-gate --phase=0`
4. 通过后执行 `plan-features`

## 核心原则

1. `Foundation` 是项目级别基座，不是单个 feature 文档。
2. 项目类型必须影响模板集合，避免生成无效负担。
3. `06_CODE_STANDARDS.md` 应作为项目级编码约束单一事实源。
4. `07_EXECUTION_PERMISSION_POLICY.md` 应作为项目级执行授权策略单一事实源。
5. 初始化只负责搭骨架，不负责替用户填写内容。
6. 覆盖已有 `Foundation` 时必须谨慎。

## 文档要求

- 主要内容使用中文
- `Foundation`、`frontend`、`backend`、`fullstack`、`Gate` 等术语可保留英文
- 路径和文件名保持与原框架一致

## 验证清单

完成后检查：
1. 已确认当前目录可作为项目根目录
2. 已确定项目类型
3. 已创建或补齐 `docs/_foundation/`
4. 已生成 `FOUNDATION_GATE_STATUS.yaml`
5. 已给出后续 `Foundation` 流程建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\00_foundation\`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\doc-design-validation.md`
