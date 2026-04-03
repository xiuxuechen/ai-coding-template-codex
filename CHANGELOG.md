# Changelog

All notable changes to the AI Coding Collaboration Framework will be documented in this file.

---

## [v3.3.0] - 2026-01-11

### 🚀 AI PM Driver 与 Foundation 体系重构

本版本引入 AI PM Driver 编排系统，并重构 Foundation 文档体系，统一 Phase 0 (Foundation) 与 Phase 1-7 (Feature) 的 Gate 检查机制。

#### Added

- **AI PM Driver 编排系统**：
  - `/ai-pm` 命令 - Driver 编排命令，支持 `start/status/pause/resume/stop/confirm/reject/skip/compare/logs/restart` 子命令
  - `ai_pm_state_manager` skill - Driver 状态管理器，管理 `AI_PM_ORCHESTRATION_STATE.yaml`
  - 支持 `full_auto` 和 `human_confirm` 两种运行模式
  - 熔断机制（max_retry/no_progress/timeout）

- **Foundation Gate (Phase 0)**：
  - `/check-gate --phase=0` - 检查项目级 Foundation Gate
  - Phase 0 检查 `docs/_foundation/` 下的规划文档
  - Phase 1-7 检查 `docs/{feature}/` 下的功能文档

#### Changed

- **Foundation 模板目录重构**：
  - 模板位置：`CC_COLLABORATION/03_templates/00_foundation/`
  - 子目录结构：`_planning/`, `_db_system/`, `_api_system/`, `_ui_system/`
  - 生成目标：`docs/_foundation/` (项目级) 而非 `docs/_system/`

- **`/init-project` 命令更新**：
  - 支持 `frontend/backend/fullstack` 三种项目类型
  - 根据项目类型选择性复制模板
  - 生成 `FOUNDATION_GATE_STATUS.yaml` 状态文件
  - 引用 `/check-gate --phase=0` 替代原 `/check-foundation-gate`

- **`/check-gate` 命令扩展**：
  - 新增 `--phase=0` 参数支持 Foundation Gate
  - 检查规划文档存在性和占位符填写状态
  - 统一 Phase 0-7 的 Gate 检查输出格式

#### Architecture

```
Phase 0 (Foundation) - 项目级别
├── docs/_foundation/_planning/      # 规划文档
├── docs/_foundation/_db_system/     # 数据库规范
├── docs/_foundation/_api_system/    # API 规范
└── docs/_foundation/_ui_system/     # UI 设计系统

Phase 1-7 (Feature) - 功能级别
└── docs/{feature}/                  # 功能模块文档
```

#### 模块版本更新

| 模块 | 版本 | 说明 |
|------|------|------|
| ai-pm-driver | v1.0 | 新增 |
| phase-gate-system | v1.3 | Phase 0 支持 |
| foundation-templates | v2.0 | 目录重构 |

---

## [v3.2.0] - 2026-01-11

### 🚀 Gate Check 可执行验证 (Executable Verification for Phase Gate)

为 Phase Gate 检查机制增加可执行验证能力，确保工作交付结果和质量的真实验证。

#### Added

- **4 种新检查类型**：
  - `exec_check` - 执行命令并验证结果（如 `npm run build`）
  - `test_check` - 执行测试并解析结果（如 `npm test`）
  - `serve_check` - 启动服务并健康检查（如 HTTP Server + curl）
  - `e2e_check` - 端到端浏览器测试（使用 MCP 浏览器工具）

- **安全边界机制**：
  - 命令白名单（npm/python/pytest/jest 等）
  - 命令黑名单（rm -rf/sudo/eval 等）
  - 工作目录限制（禁止跳出功能目录）

#### Changed

- **PHASE_GATE_TEMPLATE.yaml** - 升级至 v1.3，添加可执行检查示例
- **gate_checker.md** - 添加新检查类型的实现逻辑

#### 问题背景

在 `user-auth-auto-test` full_auto 测试中发现：
- Phase 3 Demo: `manual` 类型被跳过，Demo 从未被验证
- Phase 6 Test: 测试报告 "12/12 通过" 是伪造的，未执行任何测试

核心问题：**文件存在 ≠ 功能正确**

#### 详细文档

- 完整更新说明：`CC_COLLABORATION/07_phase_gate/GATE_CHECK_UPDATE_v1.3.md`

---

## [v3.1.0] - 2026-01-09

### 🔄 目录结构重组 (CC_COLLABORATION Restructure)

重新组织 CC_COLLABORATION 目录结构，提升可维护性并隔离 GUI 依赖。

#### Added

- **`_gui_config/`** - GUI 依赖配置隔离
  - `WORKFLOW_TEMPLATE.yaml` - 工作流框架配置
  - `PHASE_GATE.yaml` - Phase Gate UI 配置
  - `README.md` - 依赖说明文档

- **`_project_context/`** - 项目背景与协作理念
  - `FRAMEWORK_PRINCIPLES.md` - 框架核心原则
  - `COLLABORATION_GUIDE.md` - 人机协作指南
  - `ROLES_GUIDE.md` - 角色定义指南

- **`01_workflow/`** - 统一工作流文档
  - `README.md` - 导航索引
  - `01_QUICKSTART.md` - 5 分钟快速入门
  - `02_FRAMEWORK_OVERVIEW.md` - 框架整体说明
  - `03_DAILY_OPERATIONS.md` - 每日操作指南
  - `04_REFERENCE.md` - 完整参考手册（含 Git Commit 规范）
  - `recipes/` - 工作流 Recipes
    - `CONTEXT_RECOVERY.md` - 上下文恢复（合并原 COMPACT_RECOVERY + RESUME_FROM_CHECKPOINT）
    - `START_NEW_FEATURE.md` - 启动新功能
    - `END_OF_DAY.md` - 每日结束
    - `UI_DEMO.md` - Demo 生成

#### Removed

- `00_overview/` - 内容整合至 `_project_context/` 和 `01_workflow/`
- `00_system/` - 内容迁移至 `_gui_config/`
- `01_commit_rules/` - 整合至 `01_workflow/04_REFERENCE.md` 附录 A
- `02_workflows/` - 整合至 `01_workflow/`
- `04_ai_workflow/` - 整合至 `01_workflow/`
- `06_roles_guide/` - 迁移至 `_project_context/ROLES_GUIDE.md`

#### Changed

- GUI 依赖路径变更（需同步更新 ha-loop-desk）：
  - `CC_COLLABORATION/00_system/WORKFLOW_TEMPLATE.yaml` → `CC_COLLABORATION/_gui_config/WORKFLOW_TEMPLATE.yaml`
  - `CC_COLLABORATION/07_phase_gate/PHASE_GATE.yaml` → `CC_COLLABORATION/_gui_config/PHASE_GATE.yaml`

#### 保持不变

- `03_templates/` - 文档模板（GUI 依赖）
- `05_tools/` - 工具定义（GUI 依赖）
- `07_phase_gate/` - Phase Gate 配置（GUI 依赖，保留原文件）
- `08_legacy_integration/` - 现有项目整合指南

---

## [v3.0.1] - 2026-01-09

### 🔄 双向同步 (sync with ai-coding-template)

从模板仓库同步缺失的工具命令，确保两个仓库的工具集一致。

#### Added

- **10 个 slash-commands** 从模板同步回来：
  - `/gui-connect`, `/gui-cleanup`, `/gui-disconnect` - GUI 连接管理
  - `/integrate-project`, `/scan-project` - 现有项目整合
  - `/reverse-api`, `/reverse-schema` - 逆向工程文档生成
  - `/sync-docs`, `/plan-features`, `/doc-design-validation` - 文档维护工具

#### 同步说明

这些命令原本在 GUI 迁移后于模板仓库开发，此次反向同步确保开发环境拥有完整工具集。

---

## [v3.0.0] - 2025-12-31

### 🎉 Highlights

重大架构调整：将可视化工作台独立为 [HA Loop Desk](https://github.com/oowanghuan/ha-loop-desk) 项目。

### Added

- **项目 README** - 添加框架说明、目录结构、快速开始指南
- **HA Loop Desk 引用** - 作为可视化伴侣工具

### Changed

- **仓库拆分** - 可视化工作台代码迁移至独立仓库 [ha-loop-desk](https://github.com/oowanghuan/ha-loop-desk)
- **精简结构** - 移除 `apps/coding-gui/` 和 `vue-app/` 目录
- **文档归档** - GUI 设计文档移至 `_backup/coding-GUI-docs-20251231/`

### 项目定位调整

本仓库专注于 **AI 协作开发框架模板**：
- 方法论和工作流定义
- 文档模板和 Slash Commands
- Phase Gate 质量控制机制

可视化功能由 HA Loop Desk 提供：
- 甘特图进度视图
- Daily Standup 面板
- Phase Gate 状态显示

---

## [v2.4.0] - 2025-12-19

### Added

- **Phase Gate 系统** - 完整的质量关卡机制
- **Expert Review** - 外部专家评审集成
- **Dashboard View** - 多功能模块甘特图视图
- **Daily Standup** - 每日站会数据生成

### Changed

- **SDLC 7 阶段** - 从 8 阶段精简为 7 阶段（移除 Phase 0）
- **文档模板更新** - 适配新的阶段定义

---

## [v2.3.0] - 2024-12-12

### 🎉 Highlights

这是一个重要的里程碑版本，标志着框架的第一阶段开发完成。

### Added

- **开源模板仓库** - 创建 [ai-coding-template](https://github.com/oowanghuan/ai-coding-template) 独立仓库
- **「如果你只有1分钟」页面** - 5 阶段真实工作流快速入门指南
- **侧边栏新菜单** - 添加「如果你只有1分钟」导航入口
- **`/start-day` 阶段** - 在快速入门中补充每日开始步骤
- **完整日循环流程图** - 展示 `/end-day` → 第二天 → `/start-day` 的完整循环

### Changed

- **命令重命名** - `/resume` → `/iresume`，避免与 Codex 内置命令冲突
- **README 简化** - 移除开头重复的命令行示例
- **README 增强** - 添加「真实工作流：从定义到现场交付」章节

### Fixed

- 修复进度摘要弹窗样式对比度问题
- 修复 FeatureWorkbench 集成 GitHub 文档查看器

---

## [v2.2.0] - 2024-12-12

### Added

- **每日工作流命令** - `/start-day` 和 `/end-day`
- **Dashboard 每日步骤** - 所有 Phase 添加每日开始/结束步骤
- **完整测试覆盖** - 4 项核心测试全部通过

### Changed

- 优化命令输出格式
- 改进进度日志解析器

---

## [v2.1.0] - 2024-12-11

### Added

- **8 阶段工作流** - Phase 0-7 完整定义
- **项目看板** - Vue 3 + Element Plus 实现
- **进度追踪** - PROGRESS_LOG.yaml 自动解析
- **GitHub 文档查看器** - 在线查看功能文档

### Changed

- 重构文档目录结构
- 优化模板文件组织

---

## [v2.0.0] - 2024-12-10

### Added

- **Codex 工具库** - 10 个 Slash Commands
- **安装脚本** - `init-codex-tools.sh`
- **功能模板** - Context、Spec、Design、Test 等标准模板

### Changed

- 从单仓库迁移到多功能模块架构

---

## [v1.0.0] - 2024-12-09

### Added

- 初始版本
- 基础文档框架
- 核心概念定义

---

## 功能模块版本

| 模块 | 当前版本 | 最后更新 |
|------|----------|----------|
| cc-tools-library | v2.4 | 2025-12-19 |
| phase-gate-system | v1.2 | 2025-12-19 |
| schema-discovery | v1.0 | 2025-12-17 |

---

## 相关链接

- [HA Loop Desk](https://github.com/oowanghuan/ha-loop-desk) - 可视化工作台
- [开源模板仓库](https://github.com/oowanghuan/ai-coding-template)
- [Codex 官方文档](https://docs.anthropic.com/codex)

---

_Generated for Codex_
