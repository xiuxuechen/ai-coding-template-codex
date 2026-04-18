---
name: plan-features
description: 你是一个 AI 协作开发助手。用户请求从 Phase 0 的模块划分文档生成功能开发顺序清单。
---

# Plan Features


## 设计理念

> **人类单线程原则**：人在多个 feature 之间并行切换时效率低下。
> 本命令只输出「开发顺序清单」，不批量创建目录。
> 用户按清单顺序，自主决定何时执行 `/new-feature`。

## 参数

- `$ARGUMENTS`：可选参数 `--strict`

## 用法

```bash
/plan-features                    # 生成开发顺序清单
/plan-features --strict           # 严格模式：任何校验错误都中止（默认）
```

---

## 1. 输入契约

### 1.1 数据源

**唯一数据源**：`docs/_foundation/03_MODULE_DECOMPOSITION.md`

**解析范围**：只解析 `## 2. 功能模块列表` 章节下的**第一张表格**

```markdown
## 2. 功能模块列表

| module_id | feature_name | 模块名称 | 描述 | scope | deliverable | acceptance | priority | depends_on | risk | owner |
|-----------|--------------|----------|------|-------|-------------|------------|----------|------------|------|-------|
| M001 | user-auth | 用户认证 | 登录注册 | ... | ... | ... | P0 | - | ... | @name |
```

### 1.2 字段约束（强校验）

| 字段 | 格式要求 | 必填 | 说明 |
|------|----------|------|------|
| `module_id` | `^M\d{3}$` | ✅ | 唯一标识，如 M001 |
| `feature_name` | `^[a-z][a-z0-9-]*$` (kebab-case) | ✅ | 将作为 `docs/{feature_name}/` 目录名 |
| `模块名称` | 非空字符串 | ✅ | 中文名称 |
| `描述` | 非空字符串 | ✅ | 一句话描述 |
| `scope` | 非空字符串 | ✅ | 功能范围，注入到 10_CONTEXT |
| `deliverable` | 非空字符串 | ✅ | 交付物（API/UI/Tables/Jobs） |
| `acceptance` | 非空字符串 | ✅ | 验收标准 |
| `priority` | `P0\|P1\|P2\|P3` | ✅ | 优先级 |
| `depends_on` | `^M\d{3}(,M\d{3})*$` 或 `-` | ✅ | 依赖的 module_id，多个逗号分隔 |
| `risk` | 字符串，可为 `-` | ❌ | 主要风险 |
| `owner` | 字符串，可为 `-` | ❌ | 负责人 |

### 1.3 依赖合法性检查

1. **引用检查**：`depends_on` 中的 module_id 必须存在于表格中
2. **循环检测**：不允许循环依赖（A→B→C→A）
3. **拓扑排序**：输出开发批次（Batch 1/2/3）

---

## 2. 执行步骤

### 2.1 前置检查

```
1. 检查 Foundation Gate 是否通过：
   - docs/_foundation/03_MODULE_DECOMPOSITION.md 存在
   - docs/_foundation/04_ROADMAP.md 存在
   - docs/_foundation/02_ARCHITECTURE.md 存在

2. 如果任一文件不存在：
   ❌ Foundation Gate 未通过

   缺失文件：
   • {missing_files}

   请先完成 Phase 0 Foundation 文档：
   • 架构师：填写 02_ARCHITECTURE.md, 03_MODULE_DECOMPOSITION.md
   • PM：填写 04_ROADMAP.md
```

### 2.2 解析模块表

```
1. 读取 03_MODULE_DECOMPOSITION.md
2. 定位 "## 2. 功能模块列表" 章节
3. 解析第一张 Markdown 表格
4. 对每一行进行字段校验
5. 收集所有校验错误
```

### 2.3 依赖分析

```
1. 构建依赖图
2. 检测循环依赖
3. 执行拓扑排序，输出批次：
   - Batch 1：无依赖的模块
   - Batch 2：仅依赖 Batch 1 的模块
   - Batch 3：依赖 Batch 1/2 的模块
   - ...
```

### 2.4 生成开发顺序清单

基于拓扑排序结果，生成清单文件：

```
1. 按 Batch 分组，Batch 内按 module_id 排序
2. 检查每个 feature 目录是否已存在
3. 输出清单到 docs/_foundation/FEATURE_CHECKLIST.md
```

### 2.5 生成清单文件

输出清单文件：`docs/_foundation/FEATURE_CHECKLIST.md`

```markdown
# Feature 开发顺序清单

> 生成时间：{datetime}
> 数据源：docs/_foundation/03_MODULE_DECOMPOSITION.md
>
> **使用方式**：按顺序逐个执行 `/new-feature`，完成一个再开始下一个

---

## 开发顺序

### Batch 1（无依赖，可并行）

| 顺序 | module_id | feature_name | 模块名称 | 优先级 | 状态 |
|------|-----------|--------------|----------|--------|------|
| 1 | M001 | user-auth | 用户认证 | P0 | ⏳ 待开始 |

**当前应做**：`/new-feature user-auth`

---

### Batch 2（依赖 Batch 1）

| 顺序 | module_id | feature_name | 模块名称 | 依赖 | 优先级 | 状态 |
|------|-----------|--------------|----------|------|--------|------|
| 2 | M002 | user-profile | 用户资料 | M001 | P1 | 🔒 等待 M001 |
| 3 | M003 | dashboard | 仪表盘 | M001 | P1 | 🔒 等待 M001 |

---

### Batch 3（依赖 Batch 1/2）

| 顺序 | module_id | feature_name | 模块名称 | 依赖 | 优先级 | 状态 |
|------|-----------|--------------|----------|------|--------|------|
| 4 | M004 | reports | 报表 | M002,M003 | P2 | 🔒 等待 M002,M003 |

---

## 状态说明

| 状态 | 含义 |
|------|------|
| ⏳ 待开始 | 可以开始，执行 `/new-feature {name}` |
| 🔒 等待 | 依赖未完成，暂不可开始 |
| 🚧 进行中 | 已创建目录，正在开发 |
| ✅ 已完成 | 已通过所有 Phase Gate |

---

## 快速命令

```bash
# 查看当前应做的 feature
/plan-features --next

# 创建下一个 feature
/new-feature {feature_name}

# 查看某个 feature 进度
/check-progress {feature_name}
```
```

---

## 3. 失败策略

### 3.1 严格模式（默认）

```
任何一行校验失败 → 不生成清单

❌ 校验失败

错误列表：
1. M002: feature_name "UserProfile" 不符合 kebab-case
2. M003: depends_on "M999" 不存在
3. M004 → M005 → M004: 检测到循环依赖

请修复 03_MODULE_DECOMPOSITION.md 后重试
```

---

## 4. 输出示例

### 4.1 成功执行

```
✅ Feature 开发顺序清单已生成

数据源：docs/_foundation/03_MODULE_DECOMPOSITION.md
生成时间：2024-12-31T12:00:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 解析摘要：
  总模块数：5
  校验通过：5
  校验失败：0

📦 开发批次：
  Batch 1: M001 (user-auth)
  Batch 2: M002 (user-profile), M003 (dashboard)
  Batch 3: M004 (reports), M005 (settings)

📁 输出文件：
  ✅ docs/_foundation/FEATURE_CHECKLIST.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 下一步：
  1. 查看清单：docs/_foundation/FEATURE_CHECKLIST.md
  2. 按顺序开始：/new-feature user-auth
  3. 完成当前 feature 所有 Phase 后再开始下一个
```

### 4.2 已有进行中的 Feature

```
✅ Feature 开发顺序清单已更新

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 当前进度：
  ✅ 已完成：1 (M001 user-auth)
  🚧 进行中：1 (M002 user-profile)
  ⏳ 待开始：3

📦 当前应做：
  M002 user-profile (Phase 3 Demo)

💡 继续开发：
  /check-progress user-profile
```

---

## 5. 注意事项

1. **Foundation Gate**：必须先通过 Foundation Gate 才能运行此命令
2. **唯一数据源**：只从 03_MODULE_DECOMPOSITION.md 读取，不读取其他文件
3. **清单可重复生成**：每次执行会更新 FEATURE_CHECKLIST.md，自动检测已创建的 feature 目录
4. **人类单线程**：建议完成当前 feature 所有 Phase 后再开始下一个

## 关联工具

- `/check-gate --phase=0` - 检查 Foundation Gate 状态
- `/new-feature` - 创建单个功能模块
- `/check-progress` - 查看功能进度
