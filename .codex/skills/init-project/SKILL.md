---
name: init-project
description: 你是一个 AI 协作开发助手。用户请求为项目初始化 AI 协作开发框架的 Foundation 文档。
---

# Init Project


## 参数

- `$ARGUMENTS`：无需参数，在当前项目根目录执行

## 概述

`/init-project` 命令从 `CC_COLLABORATION/03_templates/00_foundation/` 模板目录复制文件到项目的 `docs/_foundation/` 目录，为项目建立 Foundation 文档体系。

**模板来源**：
```
CC_COLLABORATION/03_templates/00_foundation/
├── 00_FOUNDATION_GATE.md
├── _planning/
├── _db_system/
├── _api_system/
└── _ui_system/
```

**生成目标**：
```
docs/_foundation/
├── 00_FOUNDATION_GATE.md
├── FOUNDATION_GATE_STATUS.yaml
├── PROJECT_TRACKER.yaml
├── PROJECT_PM_STATE.yaml
├── PROJECT_ACTIVITY_LOG.yaml
├── _planning/
├── _db_system/
├── _api_system/        (仅 backend/fullstack)
└── _ui_system/         (仅 frontend/fullstack)
```

## 执行步骤

### 1. 检查项目根目录

确认当前目录是项目根目录（存在 `package.json` 或 `.git` 目录）。

如果不是，提示：
```
⚠️ 请在项目根目录执行此命令

检测条件：
• 存在 package.json 文件
• 或存在 .git 目录

当前目录：{current_dir}
```

### 2. 检查是否已初始化

检查 `docs/_foundation/` 目录是否已存在。

如果已存在，提示：
```
⚠️ 项目已初始化 Foundation 文档

现有目录结构：
docs/_foundation/
├── 00_FOUNDATION_GATE.md
├── FOUNDATION_GATE_STATUS.yaml
├── PROJECT_TRACKER.yaml
├── PROJECT_PM_STATE.yaml
├── PROJECT_ACTIVITY_LOG.yaml
├── _planning/
├── _db_system/
├── _api_system/
└── _ui_system/

是否要重新初始化？这将覆盖现有 Foundation 文档。[y/N]
```

### 3. 询问项目类型

使用 AskUserQuestion 工具询问：

```
请选择项目类型：

1. frontend - 前端项目（仅 UI 规范）
2. backend - 后端项目（仅 API/DB 规范）
3. fullstack - 全栈项目（完整规范）
```

### 4. 定位模板目录

```
模板目录位置（按优先级查找）：

1. 项目根目录：CC_COLLABORATION/03_templates/00_foundation/
2. ai-coding-template 仓库（如果是独立项目）
```

### 5. 生成 Foundation 目录结构

根据项目类型，从模板复制文件到 `docs/_foundation/`：

#### 5.1 通用文件（所有项目类型）

```yaml
always_copy:
  - from: "_planning/"
    to: "docs/_foundation/_planning/"
    files:
      - 01_USER_JOURNEY.md
      - 02_ARCHITECTURE.md
      - 03_MODULE_DECOMPOSITION.md
      - 04_ROADMAP.md
      - 05_TECH_DECISIONS.md
      - 06_CODE_STANDARDS.md
      - 07_EXECUTION_PERMISSION_POLICY.md
```

#### 5.2 后端项目 (backend / fullstack)

```yaml
backend_copy:
  - from: "_db_system/"
    to: "docs/_foundation/_db_system/"
    files:
      - 00_DB_CONVENTIONS.md

  - from: "_api_system/"
    to: "docs/_foundation/_api_system/"
    files:
      - 00_REST_CONVENTIONS.md
      - 01_COMMAND_CONVENTIONS.md
      - 02_YAML_SCHEMA_CONVENTIONS.md
      - 03_EXTERNAL_API_CONVENTIONS.md
```

#### 5.3 前端项目 (frontend / fullstack)

```yaml
frontend_copy:
  - from: "_ui_system/"
    to: "docs/_foundation/_ui_system/"
    files:
      - 00_UI_TOKENS.md
      - 01_COMPONENT_LIBRARY.md
      - 02_LAYOUT_RULES.md
      - 03_INTERACTION_RULES.md
      - 04_PAGES_TEMPLATE.md
      - 05_WORKFLOWS_TEMPLATE.md
```

### 6. 生成项目级 Foundation 运行文件

```yaml
runtime_files:
  - from: "00_FOUNDATION_GATE.md"
    to: "docs/_foundation/00_FOUNDATION_GATE.md"
    mode: "copy"
  - from: "FOUNDATION_GATE_STATUS_TEMPLATE.yaml"
    to: "docs/_foundation/FOUNDATION_GATE_STATUS.yaml"
    mode: "instantiate"
  - from: "PROJECT_TRACKER_TEMPLATE.yaml"
    to: "docs/_foundation/PROJECT_TRACKER.yaml"
    mode: "instantiate"
  - from: "PROJECT_PM_STATE_TEMPLATE.yaml"
    to: "docs/_foundation/PROJECT_PM_STATE.yaml"
    mode: "instantiate"
  - from: "PROJECT_ACTIVITY_LOG_TEMPLATE.yaml"
    to: "docs/_foundation/PROJECT_ACTIVITY_LOG.yaml"
    mode: "instantiate"
```

### 7. 输出结果

根据项目类型显示不同的输出：

#### frontend 项目

```
✅ Foundation 初始化成功！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 创建的目录结构
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

docs/_foundation/
├── _planning/                    # 项目规划文档
│   ├── 01_USER_JOURNEY.md        # 用户旅程
│   ├── 02_ARCHITECTURE.md        # 技术架构
│   ├── 03_MODULE_DECOMPOSITION.md # 模块拆分
│   ├── 04_ROADMAP.md             # 项目路线图
│   ├── 05_TECH_DECISIONS.md      # 技术决策
│   ├── 06_CODE_STANDARDS.md      # 项目级代码规范
│   └── 07_EXECUTION_PERMISSION_POLICY.md # 执行权限与授权策略
│
├── _ui_system/                   # UI 设计系统
│   ├── 00_UI_TOKENS.md           # 设计令牌
│   ├── 01_COMPONENT_LIBRARY.md   # 组件库
│   ├── 02_LAYOUT_RULES.md        # 布局规则
│   ├── 03_INTERACTION_RULES.md   # 交互规范
│   ├── 04_PAGES_TEMPLATE.md      # 页面模板
│   └── 05_WORKFLOWS_TEMPLATE.md  # 工作流模板
│
├── 00_FOUNDATION_GATE.md         # Foundation Gate 说明
├── FOUNDATION_GATE_STATUS.yaml   # Foundation Gate 状态
├── PROJECT_TRACKER.yaml          # 项目级任务追踪
├── PROJECT_PM_STATE.yaml         # Project PM Driver 状态
└── PROJECT_ACTIVITY_LOG.yaml     # 项目活动日志

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 下一步操作
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. 📖 填写 _planning/ 下的规划文档：
   • 01_USER_JOURNEY.md - 定义用户流程
   • 02_ARCHITECTURE.md - 确定技术架构
   • 03_MODULE_DECOMPOSITION.md - 拆分功能模块
   • 04_ROADMAP.md - 规划开发路线
   • 06_CODE_STANDARDS.md - 统一 AI 与人工编码规范
   • 07_EXECUTION_PERMISSION_POLICY.md - 统一执行授权分级规则

2. 🎨 完善 _ui_system/ 下的设计规范：
   • 00_UI_TOKENS.md - 定义设计令牌
   • 01_COMPONENT_LIBRARY.md - 规划组件库

3. ✅ 执行 Foundation Gate 检查：
   /check-gate --phase=0

4. 🚀 Gate 通过后，批量生成功能模块：
   /plan-features
```

#### backend 项目

```
✅ Foundation 初始化成功！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 创建的目录结构
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

docs/_foundation/
├── _planning/                    # 项目规划文档
│   ├── 01_USER_JOURNEY.md
│   ├── 02_ARCHITECTURE.md
│   ├── 03_MODULE_DECOMPOSITION.md
│   ├── 04_ROADMAP.md
│   ├── 05_TECH_DECISIONS.md
│   ├── 06_CODE_STANDARDS.md
│   └── 07_EXECUTION_PERMISSION_POLICY.md
│
├── _db_system/                   # 数据库规范
│   └── 00_DB_CONVENTIONS.md      # 命名/类型/索引规范
│
├── _api_system/                  # API 规范体系
│   ├── 00_REST_CONVENTIONS.md    # REST API 规范
│   ├── 01_COMMAND_CONVENTIONS.md # 命令式 API 规范
│   ├── 02_YAML_SCHEMA_CONVENTIONS.md
│   └── 03_EXTERNAL_API_CONVENTIONS.md
│
├── 00_FOUNDATION_GATE.md
├── FOUNDATION_GATE_STATUS.yaml
├── PROJECT_TRACKER.yaml
├── PROJECT_PM_STATE.yaml
└── PROJECT_ACTIVITY_LOG.yaml

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 下一步操作
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. 📖 填写 _planning/ 下的规划文档
   • 特别先确认 06_CODE_STANDARDS.md，作为后续 AI 编码统一约束
   • 同时确认 07_EXECUTION_PERMISSION_POLICY.md，降低高频审批打断
2. 📊 完善 _db_system/00_DB_CONVENTIONS.md 数据库规范
3. 🔌 定义 _api_system/ 下的 API 规范
4. ✅ 执行 /check-gate --phase=0
5. 🚀 Gate 通过后执行 /plan-features
```

#### fullstack 项目

```
✅ Foundation 初始化成功！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 创建的目录结构
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

docs/_foundation/
├── _planning/                    # 项目规划文档 (7 files)
├── _db_system/                   # 数据库规范 (1 file)
├── _api_system/                  # API 规范体系 (4 files)
├── _ui_system/                   # UI 设计系统 (6 files)
├── 00_FOUNDATION_GATE.md
├── FOUNDATION_GATE_STATUS.yaml
├── PROJECT_TRACKER.yaml
├── PROJECT_PM_STATE.yaml
└── PROJECT_ACTIVITY_LOG.yaml

总计：18 个模板文件

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 下一步操作
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. 📖 填写 _planning/ 下的规划文档（必需）
   • 优先完成 06_CODE_STANDARDS.md，作为所有后续编码与 review 参考
   • 建议同步完成 07_EXECUTION_PERMISSION_POLICY.md，定义开发/测试/数据库授权边界
2. 📊 完善 _db_system/ 数据库规范（有数据库时）
3. 🔌 定义 _api_system/ API 规范（有后端时）
4. 🎨 完善 _ui_system/ UI 设计系统（有前端时）
5. ✅ 执行 /check-gate --phase=0
6. 🚀 Gate 通过后执行 /plan-features
```

## 生成的文件用途

| 目录 | 用途 | 何时填写 |
|------|------|----------|
| `_planning/` | 项目规划核心文档 | 项目启动时（必需） |
| `_db_system/` | 数据库设计规范 | 有数据库时 |
| `_api_system/` | API 设计规范 | 有后端 API 时 |
| `_ui_system/` | UI 设计系统 | 有前端界面时 |

## 与其他命令的关系

```
/init-project
     │
     ▼
填写 _planning/ 文档
     │
     ▼
/check-gate --phase=0  ←── 检查 MVS 要求
     │
     ▼
/approve-gate --phase=0     ←── PM/Architect 审批
     │
     ▼
/plan-features          ←── 从 03_MODULE_DECOMPOSITION 批量生成 feature 目录
     │
     ▼
/new-feature {name}     ←── 或单独创建功能模块
```

## 注意事项

1. **此命令只创建 Foundation 文档**，不创建 `_system/CC_COLLABORATION/` 目录
2. 框架定义文件（工作流、模板等）应该在项目根目录的 `CC_COLLABORATION/` 或 `.codex/` 下
3. Foundation Gate 必须通过才能运行 `/plan-features`
4. 模板文件需要手动填写，替换 `{placeholder}` 内容
5. 建议将生成的文件提交到版本控制

## 关联命令

- `/check-gate --phase=0` - 检查 Foundation Gate 状态
- `/approve-gate --phase=0` - 审批 Foundation
- `/plan-features` - 批量生成功能模块
- `/new-feature` - 创建单个功能模块
