---
name: gui-connect
description: 你是一个 AI 协作开发助手。用户请求连接到 Coding GUI 控制台，以便接收来自 GUI 的命令。
---

# GUI Connect

## 触发方式

用户可以通过以下方式触发：
- `/gui-connect`
- "连接 GUI"
- "开启 GUI 模式"

## 功能说明

此命令将当前 CLI 终端注册为一个 GUI Session，使得 Coding GUI 可以：
1. 发现并显示此 CLI 终端
2. 向此终端发送命令
3. 监控终端状态

## 执行步骤

### 1. 检查环境

确认当前目录是有效的项目目录（存在 `.codex/` 目录）。

### 2. 创建 Session 目录

如果不存在，创建 `.codex/gui-sessions/` 目录：

```bash
mkdir -p .codex/gui-sessions
chmod 700 .codex/gui-sessions
```

### 3. 生成 Session 信息

生成唯一的 Session ID（8 位随机字符）并创建 Session 文件：

**文件路径**: `.codex/gui-sessions/session-{id}.json`

**文件内容**:
```json
{
  "id": "{8位随机ID}",
  "pid": {当前进程ID},
  "createdAt": "{ISO8601时间戳}",
  "lastActiveAt": "{ISO8601时间戳}",
  "heartbeatAt": "{ISO8601时间戳}",
  "terminal": {
    "type": "console",
    "platform": "{darwin|win32|linux}",
    "title": "codex - {项目名}"
  },
  "status": "active",
  "projectPath": "{当前项目路径}"
}
```

**文件权限**: `0600`（仅用户可读写）

### 4. 显示连接信息

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔗 GUI 连接已建立
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Session ID: {id}
状态: ✅ 活跃
项目路径: {projectPath}

📡 正在监听 GUI 命令...
   命令文件: .codex/gui-sessions/session-{id}.cmd

💡 提示：
• GUI 现在可以发现并连接到此终端
• 使用 /gui-disconnect 断开连接
• 关闭终端会自动清理 Session
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 5. 启动监听机制

**注意**: 这一步需要由 Codex 的 hooks 或后台机制实现。

监听 `.codex/gui-sessions/session-{id}.cmd` 文件的变化：
- 当文件被修改时，读取命令内容
- 检查命令的 `cmdId` 是否已执行（幂等性）
- 写入 ACK 确认文件
- 执行命令
- 写入执行结果文件

### 6. 启动心跳更新

每 30 秒更新 Session 文件中的 `heartbeatAt` 字段，以便 GUI 检测 Session 是否仍然活跃。

## 通信协议

### 命令文件格式 (.cmd)

```json
{
  "cmdId": "cmd-uuid-123",
  "timestamp": "2024-12-18T15:30:00.000Z",
  "command": "/start-day",
  "source": "gui-button",
  "context": {
    "phaseId": 5,
    "featureId": "coding-GUI",
    "stepId": "start-day"
  }
}
```

### ACK 确认文件格式 (.ack)

```json
{
  "cmdId": "cmd-uuid-123",
  "status": "received",
  "timestamp": "2024-12-18T15:30:01.000Z"
}
```

### 执行结果文件格式 (.result)

```json
{
  "cmdId": "cmd-uuid-123",
  "status": "success",
  "timestamp": "2024-12-18T15:30:05.000Z",
  "duration": 4000,
  "output": "命令执行完成",
  "error": null
}
```

## 错误处理

| 场景 | 处理方式 |
|------|----------|
| 目录创建失败 | 显示错误，提示检查权限 |
| Session 文件已存在 | 检查是否为僵尸 Session，若是则清理并重新创建 |
| 权限设置失败 | 显示警告，继续运行 |
| 命令文件读取失败 | 记录错误，等待下次触发 |

## 注意事项

- Session ID 使用随机生成，确保唯一性
- 所有时间戳使用 ISO 8601 格式
- 文件权限严格设置为 0600，防止其他用户读取
- 进程退出时自动清理 Session 文件
- 支持多个 CLI 终端同时连接（不同 Session ID）
