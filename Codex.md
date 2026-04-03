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