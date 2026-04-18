---
name: check-progress
description: 你是一个 AI 协作开发助手。用户请求查看功能模块的进度状态。
---

# Check Progress


## 参数

- `$ARGUMENTS`：可选，指定功能模块名称。如果不指定，则显示所有功能的概览。

## 执行步骤

### 1. 确定范围

**如果指定了功能名称：**
- 读取 `docs/{feature-name}/90_PROGRESS_LOG.yaml`，显示详细进度

**如果未指定功能名称：**
- 扫描 `docs/` 目录，找到所有包含 `90_PROGRESS_LOG.yaml` 的功能模块
- 显示所有功能的概览

### 2. 读取进度日志

从 `90_PROGRESS_LOG.yaml` 中提取：
- `meta` - 基本信息（功能名、阶段、状态、负责人）
- `stats` - 统计信息（总任务数、已完成、进行中、待开始）
- 各阶段的任务列表

### 3. 输出格式

#### 3.1 单功能详细视图

```
📊 进度状态 - {feature-name}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 基本信息
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 功能名称: {feature_name}
• 当前阶段: Phase {current_phase} - {phase_name}
• 状态: {status}
• 负责人: {owner}
• 开始日期: {started_at}
• 最后更新: {last_updated}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 进度概览
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{progress_bar} {completion_rate}%

总任务: {total} | ✅ {done} | 🔄 {wip} | ⏳ {pending}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📑 各阶段状态
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase 0 Foundation: {status_emoji} {status}
Phase 1 Kickoff:    {status_emoji} {status}
Phase 2 Spec:       {status_emoji} {status}
Phase 3 UI Flow:    {status_emoji} {status}
Phase 4 Review:     {status_emoji} {status}
Phase 5 Code:       {status_emoji} {status}
Phase 6 Test:       {status_emoji} {status}
Phase 7 Deploy:     {status_emoji} {status}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 当前阶段任务 - Phase {current_phase}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ 已完成:
{列出已完成的任务}

🔄 进行中:
{列出进行中的任务}

⏳ 待开始:
{列出待开始的任务}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 下一里程碑
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{next_milestone}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 提示: 使用 /iresume {feature-name} 恢复开发上下文
```

#### 3.2 全局概览视图

```
📊 项目进度概览

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
功能列表
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. {feature-name-1}
   Phase {n} | {status} | {progress_bar} {rate}%
   下一步: {next_milestone}

2. {feature-name-2}
   Phase {n} | {status} | {progress_bar} {rate}%
   下一步: {next_milestone}

3. {feature-name-3}
   Phase {n} | {status} | {progress_bar} {rate}%
   下一步: {next_milestone}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 总体统计
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 活跃功能: {active_count}
• 已完成功能: {completed_count}
• 阻塞功能: {blocked_count}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 提示: 使用 /check-progress {feature-name} 查看详情
```

### 4. 状态图例

状态映射：
- `done` → ✅ 已完成
- `wip` → 🔄 进行中
- `pending` → ⏳ 待开始
- `blocked` → 🚧 阻塞
- `skipped` → ⏭️ 跳过

进度条生成规则：
- 每 10% 一个方块
- 已完成部分：█
- 未完成部分：░
- 示例：████████░░ 80%

## 输出示例

### 单功能详细视图示例

```
📊 进度状态 - user-auth

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 基本信息
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 功能名称: 用户认证系统
• 当前阶段: Phase 5 - Code（开发实现）
• 状态: wip
• 负责人: @developer
• 开始日期: 2024-12-01
• 最后更新: 2024-12-11T15:30:00+08:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 进度概览
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
████████░░ 80%

总任务: 15 | ✅ 12 | 🔄 2 | ⏳ 1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📑 各阶段状态
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase 0 Foundation: ⏭️ skipped
Phase 1 Kickoff:    ✅ done
Phase 2 Spec:       ✅ done
Phase 3 UI Flow:    ✅ done
Phase 4 Review:     ✅ done
Phase 5 Code:       🔄 wip
Phase 6 Test:       ⏳ pending
Phase 7 Deploy:     ⏳ pending

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 当前阶段任务 - Phase 5
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ 已完成:
• [CODE-001] 创建 auth 模块目录结构
• [CODE-002] 实现登录页面路由
• [CODE-003] 完成登录表单 UI

🔄 进行中:
• [CODE-004] 实现登录 API 调用
• [CODE-005] 实现 Token 存储

⏳ 待开始:
• [CODE-006] 添加登录状态管理

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 下一里程碑
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
完成 Code 阶段，进入 Test

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 提示: 使用 /iresume user-auth 恢复开发上下文
```

## 注意事项

- 如果 `90_PROGRESS_LOG.yaml` 不存在，提示用户先运行 `/new-feature`
- 阶段名称映射：
  - Phase 0: Foundation（基础设施）
  - Phase 1: Kickoff（功能启动）
  - Phase 2: Spec（需求规格）
  - Phase 3: UI Flow（界面流程）
  - Phase 4: Review（方案评审）
  - Phase 5: Code（开发实现）
  - Phase 6: Test（测试验证）
  - Phase 7: Deploy（发布部署）
- 进度百分比 = (done / total) * 100，四舍五入取整
