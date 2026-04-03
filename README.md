# AI Coding Template Codex Edition

> 面向 Codex 的 AI 协作开发框架模板

## Attribution And Status

本仓库基于以下上游项目进行结构迁移和二次改造：

- Upstream repository: `https://github.com/oowanghuan/ai-coding-template`
- Original repository owner: `oowanghuan`
- Current direction: `Codex-first` 迁移版

当前仓库包含大量基于上游项目的改造内容，并非从零原创实现。

重要说明：
- 原仓库 README 末尾已声明 `License: MIT`。
- 但当前未看到单独的 `LICENSE` 根文件，因此仓库层面的许可证呈现仍不够标准化。
- 更稳妥的做法是继续保留上游来源说明，并尽量让原作者补一个正式 `LICENSE` 文件或明确确认授权范围。

详细说明见：[NOTICE.md](D:/project/ai-coding-template-codex/ai-coding-template-src/NOTICE.md)
## 1. 这是什么？

一套经过实战验证并已完成 Codex 适配的 **AI 协作开发框架**，包含：

- **8 阶段工作流**
- **标准化模板**
- **Codex repo-level skills**
- **Codex workflow specs / orchestration specs**
- **Phase Gate 机制**

## 2. 快速开始

> 给 Codex 看的版本：读取 [Codex_INIT.md](D:/project/ai-coding-template-codex/ai-coding-template-src/Codex_INIT.md)

### 1. 克隆仓库

```bash
git clone https://github.com/oowanghuan/ai-coding-template.git my-project
cd my-project
rm -rf .git && git init
```

### 2. 同步 Codex 工具目录

Windows：

```powershell
./scripts/init-codex-tools.ps1 -Target .
```

macOS / Linux：

```bash
./scripts/init-codex-tools.sh --target=.
```

### 3. 安装 Codex Skills

Windows：

```powershell
./scripts/install-codex-skills.ps1
```

macOS / Linux：

```bash
./scripts/install-codex-skills.sh
```

### 4. 开始 Feature Kickoff

优先参考：
- `docs/codex-playbooks/init-project.md`
- `docs/codex-playbooks/new-feature.md`
- `docs/codex-playbooks/template-consumption.md`

## 3. 目录结构

```text
my-project/
├── .codex/
│   ├── skills/               # Repo-level Codex skills
│   ├── commands/             # Codex workflow specs
│   ├── subagents/            # Codex orchestration specs
│   ├── skill-specs/          # 内部能力参考规格
│   ├── hooks/                # 辅助脚本
│   └── settings.json         # Codex 配置参考
├── CC_COLLABORATION/
├── docs/
│   └── codex-playbooks/      # Codex 执行手册
├── scripts/
└── Codex_INIT.md
```

## 4. Repo-level Skills

当前仓库内置 29 个 Codex skills：

- `doc-generator`
- `review-alignment`
- `ui-demo`
- `mock-api-generator`
- `design-from-demo`
- `contract-resolver`
- `api-scanner`
- `schema-scanner`
- `module-scanner`
- `tech-stack-detector`
- `spec-validator`
- `test-runner`
- `test-report-generator`
- `gate-checker`
- `progress-updater`
- `changelog-updater`
- `system-scaffolder`
- `schema-generator`
- `context-writer`
- `openai-expert-review`
- `ai-pm-state-manager`
- `test-plan-writer`
- `release-summarizer`
- `integrate-project`
- `reverse-api`
- `reverse-schema`
- `sync-docs`
- `template-consumption`
- `workflow-reference-preservation`

源码目录：
- `.codex/skills/`

## 5. 能力保全策略

为了保留原框架全部能力，Codex 版采用以下承载方式：

- 自动触发能力 -> `.codex/skills/`
- 原命令型工作流 -> `.codex/commands/` + `docs/codex-playbooks/`
- 原 subagent 编排 -> `.codex/subagents/`
- 原内部能力说明 -> `.codex/skill-specs/`

## 6. 初始化与安装脚本

- [init-codex-tools.ps1](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/init-codex-tools.ps1)
- [init-codex-tools.sh](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/init-codex-tools.sh)
- [install-codex-skills.ps1](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/install-codex-skills.ps1)
- [install-codex-skills.sh](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/install-codex-skills.sh)

## 7. License

MIT
