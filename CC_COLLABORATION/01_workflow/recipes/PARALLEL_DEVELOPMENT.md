# Recipe: 多 Feature 并行开发

> 使用 PM Driver 协调多个 Feature 的并行开发

---

## 适用场景

- 项目有多个独立或有依赖关系的 Feature
- 需要多个 Codex CLI 会话并行工作
- 需要追踪多 Feature 整体进度

---

## 前置条件

1. Foundation Gate (Phase 0) 已通过
2. `03_MODULE_DECOMPOSITION.md` 已定义 Feature 列表和依赖
3. `04_ROADMAP.md` 已定义里程碑

---

## 快速流程

```bash
# Step 1: 初始化项目追踪
/project-pm init

# Step 2: 为 Ready Set 中的 Feature 创建目录
/new-feature {feature-name}

# Step 3: 获取可执行任务
/project-pm ready

# Step 4: 生成 dev agent 命令
/project-pm assign

# Step 5: 在独立 CLI 会话中执行
# CLI-1: /ai-pm start feature-a --mode=full_auto
# CLI-2: /ai-pm start feature-b --mode=full_auto

# Step 6: 定期检查进度
/project-pm check
/project-pm status

# Step 7: 循环 Step 3-6 直到所有 Feature 完成
```

---

## 详细步骤

### Step 1: 初始化项目追踪

```bash
Human> /project-pm init
```

**输出示例**：
```
🚀 Project PM 初始化

已创建：
  ✅ docs/_foundation/PROJECT_TRACKER.yaml
  ✅ docs/_foundation/PROJECT_PM_STATE.yaml
  ✅ docs/_foundation/PROJECT_ACTIVITY_LOG.yaml

📋 检测到的功能模块

里程碑 M1 (MVP):
  • user-auth (priority: 1)
  • user-profile (priority: 2, blocked_by: user-auth)

Ready Set（可立即开始）:
  • user-auth
```

### Step 2: 创建 Feature 目录

对于 Ready Set 中的每个 Feature，确保目录存在：

```bash
Human> /new-feature user-auth
```

如果目录已存在，会提示跳过。

### Step 3: 获取 Ready Set

```bash
Human> /project-pm ready
```

**输出示例**：
```
📋 Ready Set - 可执行任务

可立即执行（无阻塞依赖）：
┌─────────────────┬──────────┬──────────┐
│ Feature         │ Milestone│ Priority │
├─────────────────┼──────────┼──────────┤
│ user-auth       │ M1       │ 1        │
│ config-service  │ M1       │ 3        │
└─────────────────┴──────────┴──────────┘

被阻塞：
• user-profile (blocked_by: user-auth)
```

### Step 4: 生成 Dev Agent 命令

```bash
Human> /project-pm assign
```

**输出示例**：
```
🎯 Dev Agent 命令生成

┌─────────────────────────────────────────────────────────────┐
│ Agent 1: user-auth                                          │
├─────────────────────────────────────────────────────────────┤
│ /ai-pm start user-auth --mode=full_auto --from-phase=1      │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ Agent 2: config-service                                     │
├─────────────────────────────────────────────────────────────┤
│ /ai-pm start config-service --mode=full_auto --from-phase=1 │
└─────────────────────────────────────────────────────────────┘

💡 操作步骤
1. 打开新的 Codex CLI 终端
2. 复制上述命令执行
3. 完成后执行 /project-pm check 检查进度
```

### Step 5: 在独立 CLI 会话中执行

打开多个终端窗口：

**终端 1**：
```bash
cd /path/to/project
codex

Human> /ai-pm start user-auth --mode=full_auto --from-phase=1
```

**终端 2**：
```bash
cd /path/to/project
codex

Human> /ai-pm start config-service --mode=full_auto --from-phase=1
```

### Step 6: 监控进度

在主控制台定期检查：

```bash
# 更新追踪状态
Human> /project-pm check

# 查看整体状态
Human> /project-pm status

# 查看活动日志
Human> /project-pm logs --tail=10
```

### Step 7: 处理新解锁的 Feature

当某个 Feature 完成后，会解锁依赖它的 Feature：

```bash
Human> /project-pm check
# 输出：user-auth 完成，解锁 user-profile

Human> /project-pm ready
# 输出：user-profile 现在可执行

Human> /project-pm assign
# 生成新的 dev agent 命令
```

---

## 并行度控制

### 设置最大并行数

编辑 `docs/_foundation/PROJECT_PM_STATE.yaml`：

```yaml
intent:
  max_parallel_features: 3  # 最多 3 个并行
```

### 建议配置

| 团队规模 | 建议并行数 | 说明 |
|----------|-----------|------|
| 1 人 | 1-2 | 便于切换上下文 |
| 2-3 人 | 3-5 | 每人负责 1-2 个 |
| 4+ 人 | 5+ | 充分利用并行能力 |

---

## 处理异常情况

### Feature 进入 stuck 状态

```bash
# 查看状态
Human> /ai-pm status user-auth
# 状态：🔴 stuck

# 选项 1：手动修复后恢复
# ... 修复代码 ...
Human> /ai-pm resume user-auth

# 选项 2：跳过当前阶段
Human> /ai-pm skip user-auth --reason="..." --approver="@pm"
```

### 依赖关系变更

如果需要修改依赖关系：

1. 更新 `03_MODULE_DECOMPOSITION.md`
2. 执行 `/project-pm sync`
3. 执行 `/project-pm ready` 重新计算

---

## 最佳实践

1. **命名 CLI 会话**：为每个终端窗口命名（如 "Agent-user-auth"）便于识别

2. **定期同步**：每隔 30 分钟执行 `/project-pm check` 更新状态

3. **优先处理阻塞**：如果某个 Feature 阻塞了多个其他 Feature，优先处理

4. **使用 logs 追踪**：`/project-pm logs` 查看项目活动历史

5. **里程碑为单位**：按里程碑分批开发，避免一次启动过多 Feature

---

## 相关命令速查

| 命令 | 用途 |
|------|------|
| `/project-pm init` | 初始化项目追踪 |
| `/project-pm ready` | 查看可执行任务 |
| `/project-pm assign` | 生成 dev agent 命令 |
| `/project-pm check` | 更新进度 |
| `/project-pm status` | 查看整体状态 |
| `/project-pm logs` | 查看活动日志 |
| `/ai-pm start` | 启动 Feature 开发 |
| `/ai-pm status` | 查看 Feature 状态 |
| `/ai-pm pause/resume` | 控制执行 |

---

## 参考文档

- [05_PM_DRIVER_WORKFLOW.md](../05_PM_DRIVER_WORKFLOW.md) - PM Driver 完整文档
- [START_NEW_FEATURE.md](./START_NEW_FEATURE.md) - 启动新功能开发

---

_Generated for Codex_
