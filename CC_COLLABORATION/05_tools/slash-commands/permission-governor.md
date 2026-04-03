# /permission-governor - 设计执行权限分级策略

你是一个 AI 协作开发助手。用户请求为 Codex 设计、细化或解释执行权限策略，希望减少低风险高频确认，同时保留高风险动作的人工把关。

## 参数

- `$ARGUMENTS`：可选，指定关注场景，例如 `dev`、`test`、`db-write`、`service-start`

## 用法

```
/permission-governor
/permission-governor dev
/permission-governor db-write
```

## 执行步骤

### 1. 判断是否已有项目级权限策略

优先检查：
- `docs/_foundation/_planning/07_EXECUTION_PERMISSION_POLICY.md`

如果存在：
- 先读取并基于现有 policy 给出建议

如果不存在：
- 按默认分级模型输出建议
- 如用户希望落地，创建该文档或补齐模板内容

### 2. 识别用户关心的授权场景

按语义判断重点场景，例如：
- 本地开发启动
- 本地测试执行
- 数据库读写
- 网络访问
- Git 写操作
- destructive 操作

### 3. 按三维模型分类

每个动作都按以下维度分类：

```yaml
environment:
  - local-dev
  - local-test
  - shared-dev
  - shared-test
  - staging
  - production

action:
  - read-only
  - service-control
  - safe-write
  - data-write
  - destructive
  - external-side-effect

entry:
  - project-script
  - native-command
  - seed-script
  - arbitrary-shell
  - raw-sql
```

### 4. 选择授权等级

默认建议：

- `A`：默认放行
- `B`：允许可复用前缀授权
- `C`：逐次确认
- `D`：强确认且不做持久放权

### 5. 优先收敛为脚本白名单

如果用户提到：
- `mvn spring-boot:run`
- `mysql`
- `psql`
- `bash`

应优先建议：
- 不直接对白名单整个解释器或客户端授权
- 改为固定脚本，如 `scripts/dev/run-app.sh`
- 再对白名单脚本申请窄前缀授权

### 6. 输出策略建议

至少输出：
- 动作分类结果
- 风险等级
- 推荐授权方式
- 是否适合 `prefix_rule`
- 是否建议改成项目脚本
- 明确不建议放权的动作

## 注意事项

- 不要把“减少审批”误解为“永久全局高权限”
- 不要对白名单宽泛解释器或数据库客户端做长期授权
- staging / production 操作默认进入最高风险层
- destructive action 不应进入持久化授权范围
