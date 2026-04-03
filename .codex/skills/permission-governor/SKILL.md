---
name: permission-governor
description: Govern execution permissions for Codex by classifying actions by environment, risk, and command shape, then choosing whether to auto-run, request one-time approval, request a reusable prefix approval, or require strict human confirmation. Use when the user wants fewer approval prompts, higher execution autonomy, graded permissions, or detailed policies for development, testing, database writes, service startup, dependency installs, or destructive operations.
---

# Permission Governor

## Overview

这个 skill 用来为 Codex 建立“分级授权”策略，目标是减少低风险高频确认，同时把真正危险的动作继续留给人工把关。

它不绕过 Codex 平台本身的权限与沙箱机制，只负责：
- 判断当前动作的风险等级
- 选择最合适的授权方式
- 生成更安全的授权策略与 policy 文档
- 优先把宽泛授权收敛成脚本白名单或窄前缀白名单

## Trigger Examples

- `给你更高的执行权限，但要分级`
- `我不想每次都确认，帮我设计授权方案`
- `把开发测试场景的授权细化一下`
- `哪些命令可以默认执行，哪些必须确认`
- `maven 启动项目和数据库插数要怎么授权`
- `帮我做一个执行权限 policy`

## Workflow

### 1. 先判断是否已有项目级 policy

优先读取：
- `docs/_foundation/_planning/07_EXECUTION_PERMISSION_POLICY.md`

如果不存在：
- 说明当前没有项目级策略
- 按默认分级模型给出方案
- 如用户希望落地，创建或补齐该文档

### 2. 用三维模型分类动作

每个需要授权的动作，都按以下三个维度判断：

- 环境：本地开发、本地测试、共享 dev、共享 test、staging、production
- 动作：只读、启动服务、非破坏写入、数据变更、破坏性变更、外部副作用
- 入口：原生命令、项目脚本、固定 seed 脚本、任意 shell 命令

没有完成分类前，不要直接建议“大范围放权”。

### 3. 选择授权等级

建议默认使用以下等级：

- `A`：默认放行
  - 只读
  - 工作区内低风险修改
  - 本地静态检查或编译

- `B`：允许可复用前缀授权
  - 本地启动项目
  - 本地测试执行
  - 依赖安装
  - Git add / commit / push

- `C`：逐次确认
  - 本地数据库插入测试数据
  - 重置本地测试数据
  - 共享 dev/test 环境数据写入
  - 批量导入测试数据

- `D`：强确认，不做持久放权
  - 删除、覆盖、回滚、强制重置
  - 任意手写 SQL 改库
  - schema destructive 变更
  - staging / production 操作
  - 对外系统真实副作用

### 4. 优先收敛为“脚本白名单”，不要放大到通用命令

优先建议：
- `scripts/dev/run-app.sh`
- `scripts/dev/seed-local-db.sh`
- `scripts/dev/reset-local-db.sh`
- `scripts/test/run-integration.sh`

不建议直接对白名单以下通用入口做长期授权：
- `mvn`
- `mysql`
- `psql`
- `python`
- `bash`

更稳的做法是：
- 对固定脚本申请前缀授权
- 对原生命令仅做逐次确认

### 5. 处理开发 / 测试 / 数据库典型场景

#### 本地开发启动

可以进入 `B` 类，但优先通过固定脚本执行，而不是直接对白名单整个 `mvn spring-boot:run`。

#### 本地测试

测试命令通常属于 `A` 或 `B` 类：
- 纯只读测试可默认放行或允许前缀复用
- 会写临时测试数据时需提升到 `C`

#### 数据库写入

按环境区分：
- 本地临时测试库：`C`
- 共享 dev/test：更严格的 `C`
- staging / production：`D`

按入口区分：
- 固定 seed 脚本：可逐次确认
- 任意 SQL：默认 `D`

### 6. 实际执行时如何落地

当 Codex 真要执行命令时：
- 先用 policy 判断建议等级
- 如果平台仍要求审批，按平台机制申请
- 若适合复用授权，则优先申请窄 `prefix_rule`
- justification 说明要和具体任务绑定，不要使用泛化描述

### 7. 输出建议时应包含什么

至少输出：
- 分类结果
- 风险等级
- 推荐授权方式
- 是否建议改用脚本白名单
- 不建议放权的原因

## Read Only When Needed

在需要创建或更新项目级策略时，读取：
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\template-consumption.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\00_foundation\_planning\07_EXECUTION_PERMISSION_POLICY.md`

## Do Not

- 不要声称可以绕过 Codex 平台权限模型
- 不要把“减少确认”理解成“永久全局管理员权限”
- 不要对白名单宽泛解释器或数据库客户端做长期放权
- 不要把生产环境动作和本地开发动作放在同一授权层
- 不要对 destructive action 申请持久化宽前缀授权
