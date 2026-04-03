---
name: template-consumption
description: Select and consume the correct files under `CC_COLLABORATION/03_templates` for the current workflow, preserving required structure, filenames, and YAML fields while avoiding unsafe overwrites. Use when Codex needs to create or update framework docs from templates, support `init-project`, `new-feature`, Spec/Test/Release doc generation, or handle requests like “按模板生成”, “使用框架模板”, “初始化文档模板”, or “检查模板映射”.
---

# Template Consumption

## Overview

负责在正确时机读取和消费框架模板，确保生成文档时保留结构、路径和关键字段约定，而不是每次临时即兴输出。

## Workflow

### 1. 判断当前 workflow 所需模板族

按场景选择：

- `00_foundation/`
- `01_kickoff/`
- `02_spec/`
- `03_demo/`
- `04_design/`
- `05_code/`
- `06_test/`
- `07_deploy/`
- `_shared/`

### 2. 映射模板到目标文件

至少确认：

- 来源模板路径
- 目标文档路径
- 是否允许新建
- 是否只做结构补齐
- 是否允许覆盖

### 3. 处理共享模板

对 `_shared/` 中的实例化文件：

- 初始化时创建一次
- 后续只做增量更新
- 不要反复用模板覆盖运行态文件

### 4. 保留结构并填充业务内容

允许业务化填写：

- 标题
- feature 名称
- 条目内容
- 示例和说明

不能随意破坏：

- 关键章节层级
- 文件名约定
- YAML 关键字段结构
- Gate 与其他 workflow 依赖路径

### 5. 记录模板消费结果

至少说明：

- 使用了哪些模板
- 生成了哪些文件
- 哪些文件被保守跳过
- 哪些模板或结构缺失

## Read Only When Needed

在需要模板映射规则时，读取：

- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\template-consumption.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\03_templates\README.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\init-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\new-feature.md`

## Do Not

- 不要默认把所有模板一次性复制到上下文
- 不要覆盖运行中的状态类文件
- 不要改坏 YAML 关键字段结构
- 不要在模板缺失时静默跳过不报错