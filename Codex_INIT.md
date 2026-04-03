# Codex_INIT.md
# AI 初始化指南 - 本文档供 Codex 读取并执行

> **读者**：Codex
> **目的**：以 Codex-only 方式完成项目初始化，并加载本框架的全部能力承载
> **触发方式**：用户说「初始化项目」「按 Codex 方式加载框架」「帮我配置好这个仓库」等

---

## 场景判断

```text
场景 A：用户还没有克隆模板仓库
场景 B：用户已经克隆仓库，但还没安装 Codex skills
场景 C：仓库和 Codex skills 都已就绪，准备创建或继续 feature
```

---

## 完整初始化流程

### Step 0: 克隆模板仓库

```bash
git clone https://github.com/oowanghuan/ai-coding-template.git {项目名}
cd {项目名}
rm -rf .git
git init
```

### Step 1: 安装 Codex 工具资产

如果当前仓库已经包含 `.codex/`，说明 repo-level 资产已经就位。

如需将这套 Codex 工具目录同步到目标项目，可执行：

Windows：
```powershell
./scripts/init-codex-tools.ps1 -Target .
```

macOS / Linux：
```bash
./scripts/init-codex-tools.sh --target=.
```

### Step 2: 安装 Codex skills

```powershell
./scripts/install-codex-skills.ps1
```

或：

```bash
./scripts/install-codex-skills.sh
```

默认会安装到：
- `$CODEX_HOME/skills`
- 未设置 `CODEX_HOME` 时安装到 `~/.codex/skills`

### Step 3: 校验 Codex 能力入口

至少确认：

```text
.codex/skills/
.codex/commands/
.codex/subagents/
docs/codex-playbooks/
```

### Step 4: 建立 Foundation 文档体系

优先参考：
- `docs/codex-playbooks/init-project.md`
- `docs/codex-playbooks/doc-design-validation.md`
- `docs/codex-playbooks/plan-features.md`

### Step 5: 创建第一个 feature

优先参考：
- `docs/codex-playbooks/new-feature.md`
- `docs/codex-playbooks/template-consumption.md`

目标目录：

```text
docs/{feature}/
├── 10_CONTEXT.md
├── 90_PROGRESS_LOG.yaml
├── PHASE_GATE.yaml
├── PHASE_GATE_STATUS.yaml
└── _demos/
```

### Step 6: 调用第一批 Codex skills

- 生成文档：`$doc-generator`
- 生成 Demo：`$ui-demo`
- 生成 Mock：`$mock-api-generator`
- 从 Demo 固化设计：`$design-from-demo`
- 检查实现对齐：`$review-alignment`

### Step 7: 输出初始化摘要

至少说明：
- skills 是否已安装
- `.codex/` 主路径是否完整
- `docs/_foundation/` 是否已建立
- 第一个 feature 是否已进入 Kickoff

---

## 能力承载约定

为保留原框架全部能力，Codex 侧采用分层承载：

- `.codex/skills/`：自动触发能力
- `.codex/commands/`：命令型 workflow 参考
- `.codex/subagents/`：编排型能力说明
- `.codex/skill-specs/`：内部能力参考规格
- `docs/codex-playbooks/`：落地执行手册

原则：
1. 不再依赖任何 `.codex/` 路径。
2. 不要求沿用旧产品的交互外壳，但要求能力语义完整保留。
3. 找不到自动命令时，优先落回对应 playbook 执行。

---

## 元信息

```yaml
文档版本: v2.0
最后更新: 2026-04-03
适用于: ai-coding-template-codex
```