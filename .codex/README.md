# .codex 目录说明

这是 `ai-coding-template-codex` 的 Codex-only 工具目录。

## 目录结构

- `skills/`：可安装到本地 Codex 的 repo-level skills
- `commands/`：从原框架命令体系迁移而来的 Codex workflow specs
- `subagents/`：复杂多步骤编排能力的 Codex orchestration specs
- `skill-specs/`：原框架内部能力说明的 Codex 参考规格
- `hooks/`：辅助脚本与环境桥接逻辑
- `settings.json`：仓库级 Codex 配置参考

## 设计原则

1. 项目只保留 Codex 主路径，不再保留任何 Codex 专用入口。
2. 迁移时优先保全能力，再调整承载方式。
3. `skills/` 是面向 Codex 自动发现的实际 skills。
4. `commands/`、`subagents/`、`skill-specs/` 是能力保全层，不要求一比一复刻旧产品的交互形式。

## 使用方式

1. 先读取 `Codex_INIT.md`
2. 安装 repo-level skills：
   - Windows: `./scripts/install-codex-skills.ps1`
   - macOS / Linux: `./scripts/install-codex-skills.sh`
3. 再根据 `docs/codex-playbooks/` 和 `.codex/commands/` 进入具体 workflow