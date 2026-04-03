# 项目扫描 Playbook

## 目标

扫描一个现有项目，提取其技术栈、目录结构、模块划分和文档覆盖情况，为后续整合到 `ai-coding-template` 提供输入。

这个 playbook 保留原 `/scan-project` 的核心能力：
- 检测项目类型
- 提取技术栈
- 识别目录结构和模块
- 评估已有文档
- 生成推荐整合级别

## 输入

- 项目路径：必填
- 是否保存结果：可选
- 扫描深度：可选

## 输出

至少产出一份结构化扫描结果，内容包含：
- 项目基本信息
- 技术栈
- 目录结构
- 模块划分
- 已有文档覆盖率
- 推荐整合级别
- 后续建议动作

如用户要求落盘，可保存到项目内的扫描结果文件。

## 依赖

- 可参考原命令逻辑：`.codex/commands/scan-project.md`
- 后续相关 playbooks：`integrate-project`、`reverse-api`、`reverse-schema`
- 后续可接入扫描类 utilities：`api-scanner`、`module-scanner`、`schema-scanner`、`tech-stack-detector`

## 执行步骤

### 1. 校验路径

1. 路径不能为空。
2. 路径必须存在。
3. 输出中应始终包含绝对路径，避免歧义。

### 2. 检测项目类型

优先检查以下文件：
- `package.json`
- `requirements.txt`
- `go.mod`
- `Cargo.toml`
- `pom.xml`

如果是非 JS/TS 项目：
- 仍然保留扫描结果
- 但要明确说明自动化整合能力的限制
- 给出保守整合建议

### 3. 分析技术栈

重点提取：
- 框架
- 语言
- ORM
- 数据库
- 测试框架
- 构建工具

优先从：
- `package.json`
- lockfile
- 关键配置文件
- 代码目录命名
中推断。

### 4. 分析目录结构

重点识别：
- 前端目录
- 后端目录
- 公共目录
- 测试目录
- 文档目录
- 配置目录

输出时只保留对后续整合有价值的结构信息，不必无差别列出全部文件。

### 5. 分析模块划分

基于目录结构推断主要模块，并尽量给出：
- 模块名称
- 相对路径
- 模块类型
- 文件数量或复杂度线索

### 6. 检测现有文档

至少检查：
- `README.md`
- API 文档
- 架构文档
- Schema 或数据库文档
- 测试相关文档

给出一个简化的文档覆盖率判断即可，不需要伪精确。

### 7. 生成整合建议

建议输出 `Level 0` 到 `Level 3` 的推荐级别，并说明理由：
- `Level 0`：仅登记，不做深度整合
- `Level 1`：建立最小可协作骨架
- `Level 2`：补 API 与数据模型
- `Level 3`：尽量完整接入框架

### 8. 输出报告

报告建议使用以下章节：
- 基本信息
- 技术栈
- 项目结构
- 模块划分
- 文档现状
- 推荐整合级别
- 下一步建议

## 文档要求

- 主要内容使用中文
- `Level`、`playbook`、`skills`、`Phase` 等专有名词可保留英文
- 不要为了形式感制造过度复杂的评分模型

## 验证清单

完成后检查：
1. 已识别项目路径和项目类型
2. 已给出技术栈摘要
3. 已给出关键目录和模块列表
4. 已给出文档覆盖判断
5. 已给出明确的整合级别建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\scan-project.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\CC_COLLABORATION\08_legacy_integration\`
