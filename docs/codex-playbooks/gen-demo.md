# Demo 生成 Playbook

## 目标

为指定功能模块生成轻量级、可交互的 Demo 页面，用于快速验证布局、流程和需求理解，而不是直接替代生产代码。

这个 playbook 保留原 `/gen-demo` 的核心能力：
- 校验功能目录
- 读取现有设计输入
- 生成 Demo HTML 或等价可运行产物
- 维护 Demo 版本
- 更新进度与后续动作建议

## 输入

- 功能名称：必填
- Demo 来源文档：自动判断或可手动指定
- Demo 版本说明：可选

## 输出

至少在以下目录生成或更新 Demo 产物：
- `docs/{feature}/_demos/`

建议输出示例：
- `v1_initial.html`
- `v2_with_xxx.html`
- `final.html`

## 依赖

- 参考命令：`.codex/commands/gen-demo.md`
- 相关能力：`ui-demo`、`mock-api-generator`
- 上游文档：`21_UI_FLOW_SPEC.md`、`40_DESIGN_FINAL.md`、`10_CONTEXT.md`
- 下游能力：`design-from-demo`

## 执行步骤

### 1. 校验功能目录

至少确认：
- `docs/{feature}/` 存在
- `docs/{feature}/_demos/` 存在或可创建

如果功能目录不存在：
- 明确提示先执行 `new-feature`
- 不继续生成 Demo

### 2. 选择输入文档

按优先级读取：
1. `21_UI_FLOW_SPEC.md`
2. `40_DESIGN_FINAL.md`
3. `10_CONTEXT.md`

如果三者都不存在：
- 明确提示缺少设计输入
- 不要伪造 Demo 结构

### 3. 提取 Demo 信息

至少提取：
- 页面结构
- 数据展示需求
- 核心交互流程
- 主要状态变化

### 4. 生成 Demo 产物

优先生成：
- 自包含、可直接打开的 HTML Demo
- 必要的基础交互
- 适量 Mock 数据

要求：
- Demo 是“可验证参考”，不是生产实现
- 不应为了追求完美而引入过重依赖
- 版本文件应保留迭代痕迹

### 5. 更新进度信息

如存在进度日志，应记录 Demo 生成动作，并给出后续建议：
- 评审 Demo
- 继续迭代
- 或进入正式设计提炼

### 6. 输出结果

至少输出：
- Demo 文件路径
- 基于哪个文档生成
- 当前版本说明
- 下一步建议

## 核心原则

1. Demo 用来验证理解，不是交付最终前端代码。
2. 输入越完整，Demo 越精确；输入不足时要明确说明限制。
3. Demo 产物应便于快速预览与迭代。
4. Demo 版本应有清晰命名，不直接覆盖历史版本。

## 文档要求

- 主要内容使用中文
- `Demo`、`HTML`、`Mock`、`final` 等术语可保留英文
- 文件命名和目录结构尽量保持原框架习惯

## 验证清单

完成后检查：
1. 已确认功能目录与 `_demos/` 目录
2. 已选定有效输入文档
3. 已生成至少一个可运行 Demo 产物
4. 已说明 Demo 版本与来源
5. 已给出后续评审或设计提炼建议

## 相关资料

- `D:\project\ai-coding-template-codex\ai-coding-template-src\.codex\commands\gen-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\ui-demo.md`
- `D:\project\ai-coding-template-codex\ai-coding-template-src\docs\codex-playbooks\mock-api-generator.md`
