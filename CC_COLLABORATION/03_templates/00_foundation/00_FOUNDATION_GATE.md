# 00_FOUNDATION_GATE.md
# Foundation Gate - Phase 0 验收清单

> 版本：v1.1
> 最后更新：2025-01-02
> 状态：Template

---

## 概述

**Foundation Gate** 是项目级别的准入检查点。只有通过此 Gate，才能使用 `/plan-features` 命令批量生成功能模块。

```
Foundation 文档 ──▶ Foundation Gate ──▶ /plan-features ──▶ 功能开发
     ↑                    │
     │                    │
     └── 不通过时修复 ◀──┘
```

---

## 1. Foundation Minimum Viable Spec (MVS)

> **重要**：为避免 Gate 过严或过松，以下定义每个文档的「最小可通过」必填项。

### 1.1 01_USER_JOURNEY.md MVS（需求起源层）

| 必填区块 | 最小要求 |
|----------|----------|
| 用户画像 | ≥ 1 个主要用户 |
| 主成功路径 | ≥ 3 个用户步骤（U1, U2, U3...） |
| 失败路径 | ≥ 2 个失败场景（F1, F2...） |
| 系统责任声明 | 每个用户步骤都有「系统必须做」 |
| 模块映射表 | 所有 P0 模块都有对应的用户步骤 |

### 1.2 02_ARCHITECTURE.md MVS

| 必填区块 | 最小要求 |
|----------|----------|
| 技术选型 | ≥ 3 项技术决策（前端/后端/数据库） |
| 系统边界 | 明确 In Scope / Out of Scope |
| 架构图 | 至少 1 张系统架构图 |
| 关键数据流 | ≥ 2 条核心流程 |

### 1.3 03_MODULE_DECOMPOSITION.md MVS

| 必填区块 | 最小要求 |
|----------|----------|
| 模块表格 | ≥ 1 个模块 |
| 必填字段 | module_id, feature_name, scope, deliverable, acceptance, priority |
| 依赖图 | 如有依赖，必须有依赖关系图 |

### 1.4 04_ROADMAP.md MVS

| 必填区块 | 最小要求 |
|----------|----------|
| 里程碑 | ≥ 2 个里程碑（M0 + M1） |
| MoSCoW | P0 列表非空 |
| 模块引用 | 必须使用 module_id（如 M001），禁止自由文本 |
| 验收签字 | 每个里程碑有签字人 |

---

## 2. Gate 检查清单

### 2.1 必需文档（全部必须存在）

| # | 文档 | 路径 | 负责角色 |
|---|------|------|----------|
| 1 | **用户旅程** | `docs/_foundation/01_USER_JOURNEY.md` | PM / Product |
| 2 | 架构设计 | `docs/_foundation/02_ARCHITECTURE.md` | Architect |
| 3 | 模块划分 | `docs/_foundation/03_MODULE_DECOMPOSITION.md` | Architect |
| 4 | 功能路线图 | `docs/_foundation/04_ROADMAP.md` | PM |

### 2.2 内容验证（自动检查）

#### 01_USER_JOURNEY.md 检查项

| 检查项 | 规则 | 级别 |
|--------|------|------|
| 用户画像存在 | 包含 `## 1. 用户画像` 章节且非空 | BLOCK |
| 主路径完整 | 包含 ≥ 3 个用户步骤（U1, U2, U3...） | BLOCK |
| 步骤无死路 | 每个步骤有明确的下一步或终点 | BLOCK |
| 失败路径存在 | 包含 ≥ 2 个失败场景（F1, F2...） | BLOCK |
| 系统责任完整 | 每个用户步骤都有对应的「系统必须做」 | BLOCK |
| P0 模块全映射 | 所有 P0 模块都出现在映射表中 | BLOCK |
| 映射有效 | 映射表中的 Module ID 在 03_MODULE 中存在 | BLOCK |

#### 02_ARCHITECTURE.md 检查项

| 检查项 | 规则 | 级别 |
|--------|------|------|
| 技术选型完整 | 至少包含 3 项技术决策 | BLOCK |
| 架构图存在 | 包含「架构图」或「系统架构」章节 | BLOCK |
| 部署方案定义 | 包含「部署」章节 | WARN |

#### 03_MODULE_DECOMPOSITION.md 检查项

| 检查项 | 规则 | 级别 |
|--------|------|------|
| 模块表格存在 | 包含 `## 2. 功能模块列表` 章节 | BLOCK |
| 模块 ID 格式 | 所有 module_id 符合 `^M\d{3}$` | BLOCK |
| feature_name 格式 | 所有 feature_name 符合 kebab-case | BLOCK |
| 必填字段完整 | scope, deliverable, acceptance, priority 非空 | BLOCK |
| 依赖合法 | depends_on 引用的 module_id 存在 | BLOCK |
| 无循环依赖 | 依赖图无环 | BLOCK |
| 依赖图存在 | 包含依赖关系图 | WARN |

#### 04_ROADMAP.md 检查项

| 检查项 | 规则 | 级别 |
|--------|------|------|
| 里程碑定义 | 至少定义 2 个里程碑 | BLOCK |
| MoSCoW 优先级 | 包含 P0/P1/P2 分类 | BLOCK |
| P0 容量约束 | P0 功能数量 ≤ 团队人数 × 2 | WARN |
| 签字人定义 | 每个里程碑有 `验收人` 字段 | WARN |
| 风险识别 | 至少识别 1 项风险 | WARN |

### 2.3 审批要求

| 角色 | 审批内容 | 必需 |
|------|----------|------|
| **PM / Product** | 01_USER_JOURNEY.md | ✅ |
| **Architect** | 02_ARCHITECTURE.md, 03_MODULE_DECOMPOSITION.md | ✅ |
| **PM** | 04_ROADMAP.md | ✅ |
| **Tech Lead**（可选） | 整体技术可行性 | ❌ |

### 2.4 设计验证（Design Validation）

> **重要**：在通过 Gate 之前，必须执行设计验证。

| 检查项 | 规则 | 级别 |
|--------|------|------|
| 设计验证通过 | `/doc-design-validation` 结果为 PASS | BLOCK |

**设计验证检查内容**：
- 用户流程完整性（无死路、无断裂）
- 系统责任完整性（每步都有责任声明）
- 模块映射完整性（P0 模块全覆盖）
- 边界一致性（与 Architecture 对齐）

---

## 3. Gate 判定规则

### 3.1 判定逻辑

```
IF 任一必需文档不存在:
    BLOCK ("缺少必需文档")

IF 任一 BLOCK 级检查项失败:
    BLOCK ("内容验证失败")

IF Design Validation = FAIL:
    BLOCK ("设计验证失败")

IF 任一审批未完成:
    BLOCK ("审批未完成")

IF 存在 WARN 级问题 > 5:
    BLOCK ("警告过多，请修复后继续")

ELSE:
    PASS
```

### 3.2 判定结果

| 结果 | 含义 | 后续操作 |
|------|------|----------|
| **PASS** | 可以运行 `/plan-features` | 执行批量生成 |
| **BLOCK** | 不可运行 | 修复问题后重新检查 |

---

## 4. 检查命令

### 4.1 检查 Foundation Gate

```bash
/check-gate --phase=0
```

输出示例：

```
📋 Foundation Gate 检查结果

检查时间: 2024-12-31T12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 文档存在性:
  ✅ 02_ARCHITECTURE.md
  ✅ 03_MODULE_DECOMPOSITION.md
  ✅ 04_ROADMAP.md

📊 内容验证:
  ✅ 技术选型完整 (5 项)
  ✅ 模块表格存在 (8 个模块)
  ✅ 模块 ID 格式正确
  ✅ feature_name 格式正确
  ⚠️ M003 缺少 acceptance 字段
  ✅ 依赖合法
  ✅ 无循环依赖

✍️ 审批状态:
  ✅ Architect: @alice (2024-12-30)
  ⏳ PM: 待审批

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

结果: ❌ BLOCKED

🚫 阻断原因:
  1. PM 审批未完成

📝 建议操作:
  1. 请 PM 审批 04_ROADMAP.md
  2. 执行 /approve-gate --phase=0 --role=PM
```

### 4.2 审批 Foundation Gate

```bash
/approve-gate --phase=0 --role=Architect --name="@alice"
/approve-gate --phase=0 --role=PM --name="@bob"
```

---

## 5. Foundation Gate 状态文件

Gate 状态记录在 `docs/_foundation/FOUNDATION_GATE_STATUS.yaml`：

```yaml
# FOUNDATION_GATE_STATUS.yaml
# Foundation Gate 运行状态

meta:
  last_checked: "2024-12-31T12:00:00"
  gate_state: pending  # pending | passed | blocked

documents:
  architecture:
    exists: true
    path: "docs/_foundation/02_ARCHITECTURE.md"
    checks:
      tech_stack_complete: true
      architecture_diagram: true
      deployment_defined: false

  module_decomposition:
    exists: true
    path: "docs/_foundation/03_MODULE_DECOMPOSITION.md"
    checks:
      module_table_exists: true
      module_id_format: true
      feature_name_format: true
      required_fields_complete: false
      dependencies_valid: true
      no_circular_deps: true
    validation_errors:
      - "M003: acceptance 字段为空"

  roadmap:
    exists: true
    path: "docs/_foundation/04_ROADMAP.md"
    checks:
      milestones_defined: true
      moscow_priority: true
      p0_capacity_ok: true
      signoff_defined: false
      risks_identified: true

approvals:
  architect:
    approved: true
    approved_by: "@alice"
    approved_at: "2024-12-30T10:00:00"
  pm:
    approved: false
    approved_by: null
    approved_at: null

summary:
  block_count: 1
  warn_count: 2
  gate_state: blocked
  blocked_reason: "PM 审批未完成"
```

---

## 6. 与 `/plan-features` 集成

### 6.1 `/plan-features` 前置检查

`/plan-features` 命令在执行前会自动检查 Foundation Gate：

```
1. 读取 FOUNDATION_GATE_STATUS.yaml
2. 如果 gate_state != passed:
   ❌ Foundation Gate 未通过

   请先完成 Foundation 文档并通过审批：
   • 执行 /check-gate --phase=0 查看详情
   • 修复所有 BLOCK 级问题
   • 请相关角色审批

3. 如果 gate_state == passed:
   继续执行 /plan-features
```

### 6.2 Gate 通过后

Foundation Gate 通过后：
1. 可以运行 `/plan-features` 批量生成功能目录
2. Foundation 文档进入「冻结」状态
3. 后续修改需要重新审批

---

## 7. 最佳实践

### 7.1 推荐流程

```
1. PM / Product 完成 01_USER_JOURNEY.md（需求起源层）
2. Architect 完成 02_ARCHITECTURE.md
3. Architect 完成 03_MODULE_DECOMPOSITION.md
4. PM 完成 04_ROADMAP.md
5. 执行设计验证：/doc-design-validation
6. 各角色自检：/check-gate --phase=0
7. 修复所有 BLOCK 级问题
8. 审批：
   - PM / Product: /approve-gate --phase=0 --role=PM（User Journey）
   - Architect: /approve-gate --phase=0 --role=Architect
   - PM: /approve-gate --phase=0 --role=PM（Roadmap）
9. Gate 通过后：/plan-features
```

### 7.2 常见问题

| 问题 | 解决方案 |
|------|----------|
| 模块 ID 不符合格式 | 使用 M001, M002, ... 格式 |
| feature_name 不符合格式 | 使用 kebab-case，如 user-auth |
| 循环依赖 | 检查依赖图，打破循环 |
| 审批人不明确 | 在 ROADMAP 中明确指定 |

---

## CHANGELOG

| 版本 | 日期 | 作者 | 变更内容 |
|------|------|------|----------|
| v1.1 | 2025-01-02 | codex | 新增 User Journey 层：01_USER_JOURNEY.md MVS、7 项 BLOCK 级检查、设计验证要求 |
| v1.0 | {date} | {author} | 初始版本 |
