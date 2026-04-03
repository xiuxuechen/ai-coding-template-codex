# Codex Playbooks

This folder hosts Codex-native workflow documents that preserve the operational capabilities of `ai-coding-template`.

## Purpose

The original framework distributes behavior across:
- Codex auto skills
- slash commands
- subagents
- workflow and template references

Codex uses different primitives, so this folder acts as the orchestration layer for capabilities that should be preserved without forcing everything into a single abstraction.

## Planned playbooks

### Core workflows
- `new-feature.md`
- `gen-demo.md`
- `scan-project.md`
- `integrate-project.md`
- `reverse-api.md`
- `reverse-schema.md`
- `sync-docs.md`

### Validation and delivery
- `run-tests.md`
- `check-gate.md`
- `approve-gate.md`
- `next-phase.md`
- `expert-review.md`
- `release.md`

### Daily operations
- `start-day.md`
- `end-day.md`
- `iresume.md`
- `check-progress.md`
- `daily-summary.md`

### Orchestration patterns
- `spec-writer.md`
- `test-plan-writer.md`
- `progress-tracker.md`
- `expert-reviewer.md`
- `release-summarizer.md`
- `ai-pm.md`

### Framework preservation
- `template-consumption.md`
- `workflow-reference-preservation.md`

## Playbook format

Each playbook should include:
1. Goal
2. Inputs
3. Outputs
4. Required references
5. Execution steps
6. Related skills, scripts, or future adapters
7. Validation notes

## Tracking

Use [00-capability-acceptance-matrix.md](D:/project/ai-coding-template-codex/ai-coding-template-src/docs/codex-playbooks/00-capability-acceptance-matrix.md) to track preservation status across the full framework.

## Repo-level Skills

The framework-level Codex skills live in:
- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\skills\`

These repo-level skills are the source of truth for portable Codex capability delivery. Install them into a user's local Codex home with:
- Windows: `./scripts/install-codex-skills.ps1`
- macOS / Linux: `./scripts/install-codex-skills.sh`