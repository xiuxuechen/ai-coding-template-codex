# Codex Capability Acceptance Matrix

## Goal

Track preservation of the full `ai-coding-template` capability surface during the Codex migration.

Status values:
- `not-started`
- `in-progress`
- `preserved`
- `deferred`

## Capability Matrix

| Capability family | Source artifacts | Codex target | Status | Notes |
|---|---|---|---|---|
| Foundation initialization | `init-project`, `doc-design-validation`, `plan-features`, `system_scaffolder` | Playbooks + skill | `preserved` | `init-project.md`、`doc-design-validation.md`、`plan-features.md` 已创建；`.codex/skills/system-scaffolder` 已创建并通过校验 |
| Feature kickoff | `new-feature`, `context_writer`, `doc_generator` | Playbook + skills | `preserved` | `new-feature.md` 已创建；`.codex/skills/doc-generator`、`.codex/skills/context-writer` 已在仓库 `.codex/skills/` 中创建并通过校验 |
| Spec generation | `spec_writer`, `doc_generator`, `spec_validator` | Orchestration playbook + skills | `preserved` | `spec-writer.md` 已创建；`.codex/skills/doc-generator`、`.codex/skills/spec-validator` 已在仓库 `.codex/skills/` 中创建并通过校验 |
| Demo generation | `gen-demo`, `ui_demo`, `mock_api_generator` | Playbook + skills | `preserved` | `gen-demo.md` 已创建；`ui-demo`、`mock-api-generator` skills 已在仓库 `.codex/skills/` 中创建并通过校验 |
| Design extraction | `design_from_demo` | Skill | `preserved` | `design-from-demo` skill 已在仓库 `.codex/skills/` 中创建并通过校验 |
| Design/code alignment | `review_alignment`, `sync-docs` | Skill + playbook | `preserved` | `sync-docs.md` 已创建；`review-alignment` skill 已在仓库 `.codex/skills/` 中创建并通过校验 |
| Legacy project scanning | `scan-project`, scanners | Playbooks + skills | `preserved` | `scan-project.md` 已创建；`.codex/skills/api-scanner`、`.codex/skills/schema-scanner`、`.codex/skills/module-scanner`、`.codex/skills/tech-stack-detector` 已创建并通过校验 |
| Legacy project integration | `integrate-project`, reverse commands | Playbooks + skills | `preserved` | `integrate-project.md`、`reverse-api.md`、`reverse-schema.md`、`sync-docs.md` 已创建；`.codex/skills/integrate-project`、`.codex/skills/reverse-api`、`.codex/skills/reverse-schema`、`.codex/skills/sync-docs` 已创建并通过校验 |
| Contract resolution | `contract_resolver` | Skill | `preserved` | `.codex/skills/contract-resolver` 已创建并通过校验 |
| API reverse engineering | `reverse_api` | Skill | `preserved` | `.codex/skills/reverse-api` 已创建并通过校验 |
| Schema reverse engineering | `reverse_schema` | Skill | `preserved` | `.codex/skills/reverse-schema` 已创建并通过校验 |
| Documentation synchronization | `sync_docs` | Skill | `preserved` | `.codex/skills/sync-docs` 已创建并通过校验 |
| API scanning | `api_scanner` | Skill | `preserved` | `.codex/skills/api-scanner` 已创建并通过校验 |
| Schema scanning | `schema_scanner` | Skill | `preserved` | `.codex/skills/schema-scanner` 已创建并通过校验 |
| Schema generation | `schema_generator` | Skill | `preserved` | `.codex/skills/schema-generator` 已创建并通过校验 |
| Spec validation | `spec_validator` | Skill | `preserved` | `.codex/skills/spec-validator` 已创建并通过校验 |
| Module scanning | `module_scanner` | Skill | `preserved` | `.codex/skills/module-scanner` 已创建并通过校验 |
| Tech stack detection | `tech_stack_detector` | Skill | `preserved` | `.codex/skills/tech-stack-detector` 已创建并通过校验 |
| Testing execution | `run-tests`, `test_runner`, `test_report_generator` | Playbooks + skills | `preserved` | `run-tests.md` 已创建；`.codex/skills/test-runner`、`.codex/skills/test-report-generator` 已创建并通过校验 |
| Test planning | `test_plan_writer` | Orchestration playbook + skill | `preserved` | `test-plan-writer.md` 已创建；`.codex/skills/test-plan-writer` 已创建并通过校验 |
| Phase Gate workflow | `check-gate`, `approve-gate`, `next-phase`, `gate_checker` | Playbooks + skill | `preserved` | `check-gate.md`、`approve-gate.md`、`next-phase.md` 已创建；`.codex/skills/gate-checker` 已创建并通过校验 |
| Daily operations | `start-day`, `end-day`, `iresume`, `check-progress`, `daily-summary`, `progress_tracker` | Playbooks + skill | `preserved` | `start-day.md`、`end-day.md`、`iresume.md`、`check-progress.md`、`daily-summary.md`、`progress-tracker.md` 已创建；`.codex/skills/progress-updater` 已创建并通过校验 |
| Changelog maintenance | `changelog_updater` | Skill | `preserved` | `.codex/skills/changelog-updater` 已创建并通过校验 |
| Expert review | `expert-review`, `expert_reviewer`, `openai_expert_review` | Playbook + skill adapter | `preserved` | `expert-review.md`、`expert-reviewer.md` 已创建；`.codex/skills/openai-expert-review` 已创建并通过校验 |
| Release summarization | `release`, `release_summarizer` | Playbook + skill | `preserved` | `release.md`、`release-summarizer.md` 已创建；`.codex/skills/release-summarizer` 已创建并通过校验 |
| PM orchestration | `ai-pm`, `ai_pm_state_manager` | References + orchestration + skill | `preserved` | `ai-pm.md`、`ai-pm-state-manager.md` 已创建；`.codex/skills/ai-pm-state-manager` 已创建并通过校验 |
| GUI bridge | `gui-connect`, `gui-disconnect`, `gui-cleanup` | Optional adapter/reference | `deferred` | Environment-specific |
| Template consumption | `CC_COLLABORATION/03_templates` | References + playbook + skill | `preserved` | `template-consumption.md` 已创建；`.codex/skills/template-consumption` 已创建并通过校验 |
| Workflow reference preservation | `CC_COLLABORATION/01_workflow` and `07_phase_gate` | References + skill | `preserved` | `workflow-reference-preservation.md` 已创建；`.codex/skills/workflow-reference-preservation` 已创建并通过校验 |

## Exit Criteria

A capability is only `preserved` when:
1. Its user-visible workflow still exists in Codex form.
2. Its required references or templates are still reachable.
3. Any helper logic it depends on is either implemented or explicitly linked.
4. The migration target is documented enough to execute consistently.
