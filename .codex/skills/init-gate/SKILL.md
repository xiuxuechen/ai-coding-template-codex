---
name: init-gate
description: 你是一个 AI 协作开发助手。用户请求为功能模块初始化 Phase Gate 文件。
---

# Init Gate

## 参数

- `$ARGUMENTS`：功能模块名称，例如 `user-auth`

## 用法

```text
/init-gate user-auth
```

## 执行步骤

### 1. 校验参数

如果 `$ARGUMENTS` 为空，提示用户：

```text
请提供功能名称，例如：
/init-gate user-auth
```

### 2. 校验功能目录

检查以下目录和文件是否存在：

```text
docs/{feature}/
docs/{feature}/10_CONTEXT.md
docs/{feature}/90_PROGRESS_LOG.yaml
```

如果 `docs/{feature}/` 不存在，提示用户：

```text
未找到功能模块 "{feature}"。

请先创建功能模块：
/new-feature {feature}
```

### 3. 校验模板文件

检查以下模板是否存在：

```text
CC_COLLABORATION/03_templates/_shared/PHASE_GATE_TEMPLATE.yaml
CC_COLLABORATION/03_templates/_shared/PHASE_GATE_STATUS_TEMPLATE.yaml
```

如果模板缺失，提示用户模板不完整并停止执行。

### 4. 检查目标文件是否已存在

检查以下文件：

```text
docs/{feature}/PHASE_GATE.yaml
docs/{feature}/PHASE_GATE_STATUS.yaml
```

如果两个文件都已存在，提示用户：

```text
功能模块 "{feature}" 的 Gate 文件已存在，无需重复初始化。

已存在文件：
- docs/{feature}/PHASE_GATE.yaml
- docs/{feature}/PHASE_GATE_STATUS.yaml
```

### 5. 从模板生成 Gate 文件

读取模板文件并替换占位符：

```yaml
{feature-name} -> {feature}
{date} -> 当前日期（YYYY-MM-DD）
{datetime} -> 当前时间（ISO 8601）
```

生成目标文件：

```text
docs/{feature}/PHASE_GATE.yaml
docs/{feature}/PHASE_GATE_STATUS.yaml
```

规则：

- 仅创建不存在的文件
- 不覆盖用户已有的 Gate 文件
- 保留模板中的默认 `pending` 状态

### 6. 输出结果

初始化成功后输出：

```text
Phase Gate 初始化成功

功能模块: {feature}
已创建文件:
- docs/{feature}/PHASE_GATE.yaml
- docs/{feature}/PHASE_GATE_STATUS.yaml

下一步建议：
1. 执行 /check-gate {feature} --phase=1 检查 Kickoff Gate
2. 如需审批，执行 /approve-gate {feature} --phase=1 --role=PM
```

如果只创建了部分文件，明确说明哪些是新建的，哪些原本已存在。

## 注意事项

1. 此命令只初始化 Gate 文件，不修改 `10_CONTEXT.md` 或 `90_PROGRESS_LOG.yaml`
2. `PHASE_GATE_STATUS.yaml` 初始化后应保持由 Gate 相关命令维护
3. 如果功能是通过 `/new-feature` 创建的，建议紧接着执行一次 `/init-gate`

## 关联命令

- `/new-feature` - 创建功能模块基础目录
- `/check-gate` - 检查 Gate 状态
- `/approve-gate` - 审批 Gate
- `/next-phase` - Gate 通过后推进阶段
