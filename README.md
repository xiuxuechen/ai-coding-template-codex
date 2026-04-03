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

当前仓库内置 51 个 Codex skills：

- `ai-pm`
- `ai-pm-state-manager`
- `api-scanner`
- `approve-gate`
- `changelog-updater`
- `check-gate`
- `check-progress`
- `context-writer`
- `contract-resolver`
- `daily-summary`
- `design-from-demo`
- `doc-design-validation`
- `doc-generator`
- `end-day`
- `expert-review`
- `gate-checker`
- `gen-demo`
- `gui-cleanup`
- `gui-connect`
- `gui-disconnect`
- `init-project`
- `integrate-project`
- `iresume`
- `mock-api-generator`
- `module-scanner`
- `new-feature`
- `next-phase`
- `openai-expert-review`
- `permission-governor`
- `plan-features`
- `progress-updater`
- `release`
- `release-summarizer`
- `reverse-api`
- `reverse-schema`
- `review-alignment`
- `run-tests`
- `scan-project`
- `schema-generator`
- `schema-scanner`
- `spec-validator`
- `start-day`
- `sync-docs`
- `system-scaffolder`
- `tech-stack-detector`
- `template-consumption`
- `test-plan-writer`
- `test-report-generator`
- `test-runner`
- `ui-demo`
- `workflow-reference-preservation`

源码目录：
- `.codex/skills/`

当前 `.codex/commands/*.md`（除 `README.md` 外）均已补齐同名 skill。

## 4.1 Natural-Language Trigger Examples

下面这些说法更容易触发高频 workflow skills：

- `start-day`: `开始今天工作`、`帮我恢复今天要做的事情`
- `new-feature`: `创建一个新的 feature：user-auth`、`给这个需求建一套文档骨架`
- `run-tests`: `跑一下这个 feature 的测试`、`看看测试结果并总结问题`
- `check-gate`: `检查当前 gate 状态`、`看看 Phase 2 能不能过`
- `init-project`: `初始化这个项目`、`先把 Foundation 搭起来`
- `permission-governor`: `给你更高权限但要分级`、`帮我设计执行授权策略`
- `scan-project`: `扫描这个项目结构`、`看看这个仓库是什么技术栈`
- `end-day`: `结束今天工作`、`收工前帮我整理一下`
- `release`: `生成这个 feature 的发布说明`、`准备 v1.0.0 的 release note`

如果想更稳地命中某个 skill，可以直接在自然语言里带上 skill 名，例如：`执行 new-feature，创建 user-auth`。
## 5. 能力保全策略

为了保留原框架全部能力，Codex 版采用以下承载方式：

- 自动触发能力 -> `.codex/skills/`
- 命令型工作流 -> 同名 `.codex/skills/` + `.codex/commands/` + `docs/codex-playbooks/`
- 原 subagent 编排 -> `.codex/subagents/`
- 原内部能力说明 -> `.codex/skill-specs/`

## 6. 初始化与安装脚本

- [init-codex-tools.ps1](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/init-codex-tools.ps1)
- [init-codex-tools.sh](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/init-codex-tools.sh)
- [install-codex-skills.ps1](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/install-codex-skills.ps1)
- [install-codex-skills.sh](D:/project/ai-coding-template-codex/ai-coding-template-src/scripts/install-codex-skills.sh)

## 7. License

MIT

## Upstream Attribution

本仓库基于上游项目进行 Codex-first 方向的迁移与扩展：

- Upstream repository: `https://github.com/oowanghuan/ai-coding-template`
- Original repository owner: `oowanghuan`
- Upstream README license notice: `MIT`

说明：
- 本仓库不是完全从零原创实现，而是基于上游项目的结构迁移与二次改造版本。
- 当前保留来源说明，是为了清晰区分上游原始内容与本仓库新增改造内容。
- 虽然上游 README 末尾已写明 `MIT`，但目前未看到单独的 `LICENSE` 根文件，因此这里继续保留来源与改造说明。


