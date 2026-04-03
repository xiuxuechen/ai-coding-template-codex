# Codex.md

本文件是仓库级 Codex 指令入口。

## 读取顺序

1. `Codex_INIT.md`
2. `.codex/README.md`
3. `docs/codex-playbooks/README.md`
4. 与当前任务直接相关的 `.codex/commands/`、`.codex/subagents/`、`.codex/skill-specs/` 或 playbook

## 目标

使用 Codex-only 路径加载本框架的全部能力，不依赖任何历史 `.codex/` 结构。

## 能力承载

- 自动触发能力：`.codex/skills/`
- 命令型 workflow：`.codex/commands/`
- 编排型能力：`.codex/subagents/`
- 内部能力参考：`.codex/skill-specs/`
- 落地执行手册：`docs/codex-playbooks/`

## 代码规范约束

如果项目中存在 `docs/_foundation/_planning/06_CODE_STANDARDS.md`，则在编码、重构、代码评审、测试补齐和修复建议时，应优先将其作为项目级代码规范单一事实源。

执行原则：
- 优先遵循该文档，再结合现有代码风格落地
- feature 文档可以增加更严格规则，但不应与其冲突
- 若现有代码与该规范不一致，应先说明差异，再决定沿用旧模式或推动规范升级
