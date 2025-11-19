# SQL 学习与练习项目

这是一个系统学习和练习 SQL 的项目仓库。

## 📚 项目结构

```
My-SQL/
├── 01-Basic-Syntax/      # SQL basic syntax practice
├── 02-Query-Operations/  # SELECT query practice
├── 03-Data-Operations/   # INSERT, UPDATE, DELETE
├── 04-Advanced-Queries/  # JOIN, subqueries, aggregate functions
├── 05-Database-Design/   # Table design, indexes, constraints
├── 06-Practical-Projects/ # Comprehensive practice projects
├── sample-data/          # Sample data and database scripts
└── notes/                # Learning notes and summaries

```

## 🎯 学习路线

### 第一阶段：基础入门
- [ ] 了解数据库基本概念
- [ ] 学习 SQL 基本语法
- [ ] 掌握数据类型和约束
- [ ] 练习基本的 CRUD 操作

### 第二阶段：查询进阶
- [ ] 掌握 WHERE 条件筛选
- [ ] 学习 ORDER BY 和 GROUP BY
- [ ] 理解聚合函数（COUNT, SUM, AVG, MAX, MIN）
- [ ] 练习多表连接（JOIN）

### 第三阶段：高级应用
- [ ] 子查询和嵌套查询
- [ ] 视图和存储过程
- [ ] 事务和并发控制
- [ ] 索引和性能优化

### 第四阶段：实战项目
- [ ] 设计完整的数据库系统
- [ ] 解决实际业务问题
- [ ] 数据分析和报表查询

## 🛠️ 推荐工具

### 数据库管理系统
- **MySQL** - 最流行的开源数据库
- **PostgreSQL** - 功能强大的开源数据库
- **SQLite** - 轻量级嵌入式数据库（适合练习）

### 客户端工具
- **MySQL Workbench** - MySQL 官方图形界面
- **DBeaver** - 通用数据库工具
- **TablePlus** - macOS 上的优秀数据库客户端
- **VSCode + SQL 插件** - 在编辑器中直接操作

## 🚀 快速开始

### 1. 安装数据库

**安装 MySQL（推荐）：**
```bash
# macOS (使用 Homebrew)
brew install mysql
brew services start mysql

# 初次设置
mysql_secure_installation
```

**或者使用 SQLite（更简单）：**
```bash
# macOS 已自带 SQLite
sqlite3 --version

# 创建一个练习数据库
sqlite3 practice.db
```

### 2. 导入示例数据

```bash
# MySQL
mysql -u root -p < sample-data/init.sql

# SQLite
sqlite3 practice.db < sample-data/init-sqlite.sql
```

### 3. 开始练习

从 `01-Basic-Syntax` 目录开始，按顺序完成每个练习文件。

## 📖 学习资源

- [SQL Tutorial - W3Schools](https://www.w3schools.com/sql/)
- [MySQL 官方文档](https://dev.mysql.com/doc/)
- [PostgreSQL 教程](https://www.postgresql.org/docs/)
- [LeetCode Database 题目](https://leetcode.com/problemset/database/)

## 📝 练习记录

在每个练习文件中记录：
- 练习日期
- 遇到的问题
- 解决方案
- 心得体会

## 🤝 贡献

这是个人学习项目，欢迎添加更多练习和笔记！

---

**开始日期：** 2025年11月19日  
**学习目标：** 掌握 SQL 核心技能，能够独立设计和查询数据库
