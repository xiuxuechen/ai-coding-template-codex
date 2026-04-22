---
name: new-feature
description: 你是一个 AI 协作开发助手。用户请求创建一个新的功能模块。
---

# New Feature


## 参数

- `$ARGUMENTS`：功能模块名称（如 `user-auth`、`payment-system`）

## 执行步骤

### 1. 验证参数

如果 `$ARGUMENTS` 为空，请提示用户：
```
请提供功能名称，例如：/new-feature user-auth
```

### 2. 创建功能目录

在 `docs/` 下创建功能目录：

```
docs/{feature-name}/
├── 10_CONTEXT.md          # 功能上下文（必需）
├── 90_PROGRESS_LOG.yaml   # 进度日志（必需）
└── _demos/                # Demo 文件目录
    └── .gitkeep           # 保持目录存在
```

创建 `_demos/` 目录用于存放该功能的 Demo 文件（由 `/gen-demo` 命令生成）。

### 3. 生成 10_CONTEXT.md（智能模式 vs 模板模式）

根据用户是否提供功能描述，选择不同的生成模式：

#### 3.1 智能生成模式（用户提供了功能描述）

如果用户提供了功能描述（如 `/new-feature user-auth "用户登录注册模块，支持邮箱验证"`），则：

**步骤 A：解析需求描述**

从用户描述中自动提取：
- **核心功能点**：登录、注册、邮箱验证...
- **目标用户**：普通用户、管理员...
- **业务价值**：提高安全性、改善用户体验...
- **关键约束**：密码加密、Token 有效期...

**步骤 B：自动生成用户故事**

根据提取的信息，生成 User Story 格式：

```markdown
### US-001: 用户登录
**作为** 注册用户
**我想要** 使用邮箱和密码登录系统
**以便于** 访问我的个人数据和功能

**验收标准**：
- [ ] 支持邮箱+密码登录
- [ ] 登录失败显示错误提示
- [ ] 登录成功跳转到首页
```

**步骤 C：自动定义功能边界**

```markdown
### 包含（In Scope）
- 邮箱密码登录
- 用户注册
- 邮箱验证

### 不包含（Out of Scope）
- 第三方登录（OAuth）
- 多因素认证（MFA）
```

**步骤 D：自动识别约束条件**

```markdown
### 技术约束
- 密码必须加密存储（bcrypt）
- Token 有效期 24 小时

### 业务约束
- 邮箱必须唯一
- 密码至少 8 位
```

#### 3.2 模板模式（用户未提供描述）

如果用户只提供了功能名称，则使用以下模板生成 `10_CONTEXT.md`：

```markdown
# 10_CONTEXT.md
# {Feature Name} - 功能上下文

> 版本：v0.1
> 最后更新：{current_date}
> 状态：Draft
> 负责人：{请补充}

---

## 1. 功能概述

### 1.1 背景

{请描述功能背景和解决的问题}

### 1.2 目标

- **目标 1**：{请补充}
- **目标 2**：{请补充}
- **目标 3**：{请补充}

### 1.3 预期价值

| 价值点 | 衡量指标 | 目标值 |
|--------|----------|--------|
| {价值1} | {指标} | {目标} |

---

## 2. 功能范围

### 2.1 包含内容（In Scope）

- {请列举}

### 2.2 不包含内容（Out of Scope）

- {请列举}

### 2.3 未来规划（Future Scope）

- {请列举}

---

## 3. 用户与场景

### 3.1 目标用户

| 用户类型 | 描述 | 核心诉求 |
|----------|------|----------|
| {用户1} | {描述} | {诉求} |

### 3.2 核心场景

#### 场景 1：{场景名称}

```
角色：{角色}
目的：{目的}
前置条件：{条件}
步骤：
  1. {步骤1}
  2. {步骤2}
预期结果：{结果}
```

---

## 4. 技术方案

{请在 Spec 阶段补充}

---

## 5. 依赖与集成

### 5.1 内部依赖

| 依赖模块 | 依赖内容 | 状态 |
|----------|----------|------|
| {模块} | {内容} | {状态} |

### 5.2 外部依赖

| 外部系统 | 集成方式 | 状态 |
|----------|----------|------|
| {系统} | {方式} | {状态} |

---

## 6. 里程碑

| 阶段 | 交付物 | 状态 |
|------|--------|------|
| Kickoff | 10_CONTEXT.md | Draft |
| Spec | 40_DESIGN_FINAL.md | 待开始 |
| Code | 功能实现 | 待开始 |
| Test | 测试报告 | 待开始 |
| Deploy | 上线 | 待开始 |

---

## 7. 相关文档

- 工作流总纲：`docs/_system/CC_COLLABORATION/04_AI_WORKFLOW.md`
- 进度日志：`docs/{feature-name}/90_PROGRESS_LOG.yaml`

---

## CHANGELOG

| 版本 | 日期 | 作者 | 变更内容 |
|------|------|------|----------|
| v0.1 | {current_date} | {作者} | 初始版本 |
```

### 4. 生成 90_PROGRESS_LOG.yaml

使用以下模板生成 `90_PROGRESS_LOG.yaml`：

```yaml
# 90_PROGRESS_LOG.yaml
# 功能模块：{Feature Name}
# 最后更新：{current_datetime}

meta:
  feature: {feature-name}
  feature_name: "{Feature Name}"
  current_phase: 1  # Kickoff
  status: wip
  owner: "{请补充}"
  started_at: {current_date}
  last_updated: {current_datetime}

# ============================================================
# Phase 1: Kickoff（功能启动）- 进行中
# ============================================================
phase_1_kickoff:
  status: wip
  tasks:
    - id: KICK-001
      task: "创建功能目录 docs/{feature-name}/"
      status: done
      completed_at: {current_date}

    - id: KICK-002
      task: "编写 10_CONTEXT.md 功能上下文"
      status: wip
      notes: "需要补充功能描述和目标"

    - id: KICK-003
      task: "创建 90_PROGRESS_LOG.yaml"
      status: done
      completed_at: {current_date}

# ============================================================
# Phase 2: Spec（需求规格）- 待开始
# ============================================================
phase_2_spec:
  status: pending
  tasks:
    - id: SPEC-001
      task: "编写 40_DESIGN_FINAL.md"
      status: pending

# ============================================================
# Phase 5: Code（开发实现）- 待开始
# ============================================================
phase_5_code:
  status: pending
  tasks: []

# ============================================================
# Codex 断点恢复信息
# ============================================================
cc_checkpoint:
  session_id: "cc-{current_date}-{feature-name}"
  last_file_edited: "docs/{feature-name}/10_CONTEXT.md"
  last_action: "创建功能目录和初始文档"
  next_step: "补充 10_CONTEXT.md 中的功能描述和目标"
  context_files:
    - "docs/{feature-name}/10_CONTEXT.md"
    - "docs/{feature-name}/90_PROGRESS_LOG.yaml"

# ============================================================
# 统计信息
# ============================================================
stats:
  total_tasks: 4
  done: 2
  wip: 1
  pending: 1
  completion_rate: "50%"
  next_milestone: "完成 Kickoff 阶段，进入 Spec"
```

### 5. 输出结果

创建完成后，输出以下信息：

```
✅ 功能模块 "{feature-name}" 创建成功！

📁 目录结构：
docs/{feature-name}/
├── 10_CONTEXT.md          # 功能上下文
├── 90_PROGRESS_LOG.yaml   # 进度日志
└── _demos/                # Demo 文件目录

📝 下一步操作：
1. 补充 10_CONTEXT.md 中的功能描述、目标和范围
2. 执行 /init-gate {feature-name} 初始化 Phase Gate 文件
3. 与团队确认功能上下文后，将状态改为 Approved
4. 进入 Spec 阶段，编写 40_DESIGN_FINAL.md

💡 提示：
- 使用 /check-progress {feature-name} 查看进度
- 使用 /iresume {feature-name} 恢复工作上下文
```

## 注意事项

- 功能名称使用 kebab-case（如 `user-auth`，不是 `userAuth`）
- 自动生成的文档是框架，需要人工补充内容
- 10_CONTEXT.md 状态默认为 Draft，确认后改为 Approved
