---
name: scan-project
description: 你是一个 AI 协作开发助手。用户请求扫描一个现有项目，分析其结构和技术栈，为整合到 AI 协作框架做准备。
---

# Scan Project


## 参数

- `$ARGUMENTS`：项目路径（如 `./my-project` 或 `/path/to/project`）

## 用法

```
/scan-project ./my-project
/scan-project /Users/me/projects/legacy-app
/scan-project .   # 扫描当前目录
```

## 执行步骤

### 1. 验证参数

```
如果 $ARGUMENTS 为空：
  提示：请提供项目路径，例如：/scan-project ./my-project

如果路径不存在：
  提示：❌ 路径不存在：{path}
```

### 2. 检测项目类型

读取以下文件判断项目类型：

```
检查文件存在性：
  - package.json     → Node.js/前端项目
  - requirements.txt → Python 项目（暂不支持）
  - go.mod           → Go 项目（暂不支持）
  - Cargo.toml       → Rust 项目（暂不支持）
  - pom.xml          → Java 项目（暂不支持）

如果是非 JS/TS 项目：
  ⚠️ 检测到非 JavaScript/TypeScript 项目

  当前仅支持 JS/TS 项目的自动化整合。
  建议使用 Level 0 手动整合：
  /integrate-project {project} --level=0 --manual
```

### 3. 分析 package.json

```yaml
# 提取关键信息
project_info:
  name: {package.name}
  version: {package.version}
  description: {package.description}

# 分析依赖判断技术栈
tech_stack:
  framework:
    - 检测 vue/vue-router → Vue
    - 检测 react/react-dom → React
    - 检测 @angular/core → Angular
    - 检测 express → Express
    - 检测 koa → Koa
    - 检测 @nestjs/core → NestJS
    - 检测 next → Next.js
    - 检测 nuxt → Nuxt

  language:
    - 检测 typescript → TypeScript
    - 否则 → JavaScript

  orm:
    - 检测 prisma → Prisma
    - 检测 typeorm → TypeORM
    - 检测 sequelize → Sequelize
    - 检测 mongoose → Mongoose

  database:
    - 检测 pg/postgres → PostgreSQL
    - 检测 mysql2 → MySQL
    - 检测 mongodb → MongoDB
    - 检测 sqlite3 → SQLite

  testing:
    - 检测 jest → Jest
    - 检测 vitest → Vitest
    - 检测 mocha → Mocha

  build:
    - 检测 vite → Vite
    - 检测 webpack → Webpack
    - 检测 esbuild → esbuild
    - 检测 rollup → Rollup
```

### 4. 分析目录结构

```
扫描项目根目录，识别关键目录：

frontend_dirs:
  - src/components → 组件目录
  - src/views / src/pages → 页面目录
  - src/router → 路由配置
  - src/store / src/stores → 状态管理
  - src/assets → 静态资源
  - public → 公共资源

backend_dirs:
  - src/controllers / src/controller → 控制器
  - src/services / src/service → 服务层
  - src/models / src/model → 数据模型
  - src/routes / src/router → 路由定义
  - src/middleware → 中间件
  - prisma → Prisma Schema
  - src/entities → TypeORM 实体

common_dirs:
  - src/utils / src/lib → 工具函数
  - src/types → TypeScript 类型
  - src/config → 配置文件
  - tests / __tests__ / test → 测试目录
  - docs → 文档目录
```

### 5. 分析模块划分

```
基于目录结构推断模块：

modules:
  - name: {目录名}
    path: {相对路径}
    type: component | page | service | model | util | config
    files_count: {文件数量}

# 示例
modules:
  - name: "user"
    path: "src/modules/user"
    type: "module"
    files_count: 8
  - name: "auth"
    path: "src/services/auth"
    type: "service"
    files_count: 3
```

### 6. 检测现有文档

```
检查以下文件是否存在：

existing_docs:
  readme: {README.md 存在?}
  api_doc: {检测 openapi.yaml, swagger.json, api.md}
  architecture: {检测 ARCHITECTURE.md, architecture.md}
  database_schema: {检测 schema.prisma, *.sql, ERD.*}

documentation_score:
  - 0-20%: 几乎无文档
  - 20-50%: 基础文档
  - 50-80%: 文档较完整
  - 80-100%: 文档完善
```

### 7. 生成建议的整合级别

```
根据以下规则建议整合级别：

如果 只需要追踪，不再活跃开发：
  建议 Level 0

如果 仍在活跃开发，需要新功能：
  如果 文档覆盖率 < 30%：
    建议 Level 1（先建骨架）
  如果 有 API 且需要 AI 理解：
    建议 Level 2
  如果 要作为标杆项目：
    建议 Level 3
```

### 8. 输出扫描报告

```
📊 项目扫描报告：{project_name}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 基本信息
  名称：{name}
  版本：{version}
  描述：{description}
  路径：{absolute_path}

🔧 技术栈
  框架：{framework}
  语言：{language}
  ORM：{orm or "无"}
  数据库：{database or "未检测到"}
  测试：{testing or "无"}
  构建：{build}

📁 项目结构
  类型：{frontend | backend | fullstack | library}
  主要目录：
    {列出关键目录}

📦 模块划分（共 {N} 个）
  {列出主要模块}

📄 现有文档
  README：{✅ | ❌}
  API 文档：{✅ | ❌}
  架构文档：{✅ | ❌}
  数据库 Schema：{✅ | ❌}
  文档覆盖率：{score}%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 建议整合级别：Level {N}

理由：
  {列出建议理由}

📝 下一步操作：
  执行：/integrate-project {project_path} --level={N}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 9. 保存扫描结果（可选）

```
如果用户指定 --save：
  保存到 {project_path}/.ai-coding/scan-result.yaml

scan_result:
  scanned_at: {datetime}
  project_info: {...}
  tech_stack: {...}
  modules: [...]
  existing_docs: {...}
  recommended_level: {N}
```

## 输出示例

```
📊 项目扫描报告：vue-admin-dashboard

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 基本信息
  名称：vue-admin-dashboard
  版本：2.1.0
  描述：Admin dashboard built with Vue 3
  路径：/Users/dev/projects/vue-admin-dashboard

🔧 技术栈
  框架：Vue 3 + Vue Router + Pinia
  语言：TypeScript
  ORM：无
  数据库：未检测到（可能是纯前端）
  测试：Vitest
  构建：Vite

📁 项目结构
  类型：frontend
  主要目录：
    ✓ src/components (24 files)
    ✓ src/views (12 files)
    ✓ src/router
    ✓ src/stores
    ✓ src/composables

📦 模块划分（共 6 个）
  • dashboard - 仪表盘页面
  • user - 用户管理
  • settings - 系统设置
  • auth - 认证相关
  • shared - 共享组件
  • utils - 工具函数

📄 现有文档
  README：✅
  API 文档：❌
  架构文档：❌
  数据库 Schema：N/A
  文档覆盖率：25%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 建议整合级别：Level 1

理由：
  • 项目仍在活跃开发（最近有提交）
  • 文档覆盖率较低，需要建立基础文档
  • 纯前端项目，不需要 API/DB 逆向

📝 下一步操作：
  执行：/integrate-project ./vue-admin-dashboard --level=1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 注意事项

1. **不修改项目文件**：扫描是只读操作，不会修改任何文件
2. **隐私考虑**：不会读取 .env 或其他敏感配置文件的内容
3. **大型项目**：对于超过 1000 个文件的项目，只扫描关键目录
4. **Monorepo**：如果检测到 monorepo 结构，建议逐个子项目扫描

## 关联命令

- `/integrate-project` - 执行整合
- `/reverse-api` - API 逆向生成
- `/reverse-schema` - 数据模型逆向
