# .codex 目录说明

这是 `ai-coding-template-codex` 的 Codex-only 工具目录。

## 目录结构

- `skills/`：可安装到本地 Codex 的 repo-level skills
- `subagents/`：复杂多步骤编排能力的 Codex orchestration specs
- `skill-specs/`：原框架内部能力说明的 Codex 参考规格
- `hooks/`：辅助脚本与环境桥接逻辑
- `settings.json`：仓库级 Codex 配置参考

## 使用方式

1. 先读取 `Codex_INIT.md`
2. 安装 repo-level skills：
   - Windows: `./scripts/install-codex-skills.ps1`
   - macOS / Linux: `./scripts/install-codex-skills.sh`
3. 再根据 `docs/codex-playbooks/` 和 `.codex/commands/` 进入具体 workflow

## 目录

```
skills/
├── README.md                # 本文件
│
├── # 每日工作流（5 个）
├── start-day.md             # 开始一天工作
├── end-day.md               # 结束一天工作
├── iresume.md               # 恢复上下文
├── check-progress.md        # 查看进度状态
├── daily-summary.md         # 生成每日总结
│
├── # 功能开发（4 个）
├── new-feature.md           # 创建新功能模块
├── gen-demo.md              # 生成 Demo
├── run-tests.md             # 执行测试
├── release.md               # 发布版本
│
├── # Phase Gate 管理（4 个）
├── check-gate.md            # 检查 Gate 状态
├── approve-gate.md          # 审批 Gate
├── next-phase.md            # 进入下一阶段
├── expert-review.md         # 专家评审
│
├── # Foundation 阶段（4 个）
├── init-project.md          # 初始化项目
├── doc-design-validation.md # 验证设计文档
├── plan-features.md         # 生成功能清单
├── permission-governor.md   # 设计执行权限策略
│
├── # Legacy 项目整合（5 个）
├── integrate-project.md     # 整合现有项目
├── scan-project.md          # 扫描项目结构
├── reverse-api.md           # 逆向生成 API 文档
├── reverse-schema.md        # 逆向生成数据模型
├── sync-docs.md             # 同步文档
│
└── # GUI 连接（3 个）
    ├── gui-connect.md       # 连接 GUI 工作台
    ├── gui-disconnect.md    # 断开 GUI 连接
    └── gui-cleanup.md       # 清理 GUI Session
```

## 命令列表（25 个）

### 每日工作流

| 命令 | Phase | 用途 | 状态 |
|------|-------|------|------|
| `/start-day` | 跨阶段 | 每天开始工作，同步上下文 | ✅ 已实现 |
| `/end-day` | 跨阶段 | 每天结束，保存进度 | ✅ 已实现 |
| `/iresume` | 跨阶段 | 从断点恢复工作上下文 | ✅ 已实现 |
| `/check-progress` | 跨阶段 | 查看当前进度状态 | ✅ 已实现 |
| `/daily-summary` | 跨阶段 | 生成每日工作总结 | ✅ 已实现 |

### 功能开发

| 命令 | Phase | 用途 | 状态 |
|------|-------|------|------|
| `/new-feature` | Phase 1 | 创建新功能模块文档目录 | ✅ 已实现 |
| `/gen-demo` | Phase 3 | 生成可交互的 Demo | ✅ 已实现 |
| `/run-tests` | Phase 6 | 执行测试计划 | ✅ 已实现 |
| `/release` | Phase 7 | 生成发布说明 | ✅ 已实现 |

### Phase Gate 管理

| 命令 | Phase | 用途 | 状态 |
|------|-------|------|------|
| `/check-gate` | 跨阶段 | 检查当前阶段 Gate 状态 | ✅ 已实现 |
| `/approve-gate` | 跨阶段 | 人工审批通过 Gate | ✅ 已实现 |
| `/next-phase` | 跨阶段 | Gate 通过后进入下一阶段 | ✅ 已实现 |
| `/expert-review` | 跨阶段 | 调用 OpenAI 独立评审 | ✅ 已实现 |

### Foundation 阶段

| 命令 | Phase | 用途 | 状态 |
|------|-------|------|------|
| `/init-project` | Phase 0 | 初始化项目目录结构 | ✅ 已实现 |
| `/doc-design-validation` | Phase 0 | 验证 Foundation 文档完整性 | ✅ 已实现 |
| `/plan-features` | Phase 0 | 从 User Journey 提取功能清单 | ✅ 已实现 |
| `/permission-governor` | Phase 0 / 跨阶段 | 设计 Codex 执行权限分级策略 | ✅ 已实现 |

### Legacy 项目整合

| 命令 | Phase | 用途 | 状态 |
|------|-------|------|------|
| `/integrate-project` | - | 将现有项目纳入框架管理 | ✅ 已实现 |
| `/scan-project` | - | 扫描项目结构和技术栈 | ✅ 已实现 |
| `/reverse-api` | - | 从代码逆向生成 API 文档 | ✅ 已实现 |
| `/reverse-schema` | - | 从 ORM 逆向生成数据模型 | ✅ 已实现 |
| `/sync-docs` | - | 检查代码与文档一致性 | ✅ 已实现 |

### GUI 连接（HA Loop Desk）

| 命令 | Phase | 用途 | 状态 |
|------|-------|------|------|
| `/gui-connect` | - | 建立与 HA Loop Desk 的连接 | ✅ 已实现 |
| `/gui-disconnect` | - | 断开 GUI 连接 | ✅ 已实现 |
| `/gui-cleanup` | - | 清理过期的 GUI Session | ✅ 已实现 |

## 使用方式

### 基本调用

```bash
# 直接调用命令
/new-feature user-auth

# 带参数调用
/check-gate user-auth --phase=2

# 指定角色审批
/approve-gate user-auth --phase=2 --role=PM
```

### 典型工作流

```bash
# 早上开始工作
/start-day

# 恢复昨天的上下文
/iresume

# 检查进度
/check-progress

# 工作...

# 下班前
/end-day
```

## 命令文件格式

每个命令文件遵循统一格式：

```markdown
# /command-name - {简短描述}

## 元信息
- 类型: Command
- Phase: 适用阶段
- 优先级: P0 / P1 / P2

## 用途
{详细说明命令的作用}

## 使用方式
{语法和参数说明}

## 执行逻辑
{分步骤说明执行流程}

## 输入
{需要什么输入}

## 输出
{会产出什么}

## 调用的 Skills / Subagents
{列出依赖的工具}

## 示例
{使用示例}
```

## 与工作流的关系

```
Phase 0 Foundation    → /init-project, /doc-design-validation, /plan-features, /permission-governor
Phase 1 Kickoff       → /new-feature
Phase 3 Demo          → /gen-demo
Phase 6 Test          → /run-tests
Phase 7 Deploy        → /release

跨阶段通用            → /start-day, /end-day, /iresume, /check-progress, /daily-summary
                      → /check-gate, /approve-gate, /next-phase, /expert-review

Legacy 整合           → /integrate-project, /scan-project, /reverse-api, /reverse-schema, /sync-docs

GUI 连接              → /gui-connect, /gui-disconnect, /gui-cleanup
```