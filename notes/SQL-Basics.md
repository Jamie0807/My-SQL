# SQL 基础知识笔记

## 什么是 SQL？

SQL（Structured Query Language，结构化查询语言）是用于管理关系型数据库的标准语言。

### SQL 的主要功能

1. **数据定义（DDL - Data Definition Language）**
   - CREATE - 创建数据库对象
   - ALTER - 修改数据库对象
   - DROP - 删除数据库对象
   - TRUNCATE - 清空表数据

2. **数据操作（DML - Data Manipulation Language）**
   - SELECT - 查询数据
   - INSERT - 插入数据
   - UPDATE - 更新数据
   - DELETE - 删除数据

3. **数据控制（DCL - Data Control Language）**
   - GRANT - 授予权限
   - REVOKE - 撤销权限

4. **事务控制（TCL - Transaction Control Language）**
   - BEGIN/START TRANSACTION - 开始事务
   - COMMIT - 提交事务
   - ROLLBACK - 回滚事务

## 数据库基本概念

### 1. 数据库（Database）
存储数据的容器，一个数据库包含多个表。

### 2. 表（Table）
数据的集合，由行和列组成。

### 3. 列（Column / Field）
表中的字段，定义了数据的类型。

### 4. 行（Row / Record）
表中的一条记录。

### 5. 主键（Primary Key）
唯一标识表中每一行的字段，不能为 NULL，不能重复。

### 6. 外键（Foreign Key）
建立表之间关系的字段，引用另一个表的主键。

### 7. 索引（Index）
提高查询速度的数据结构。

## 常用数据类型

### 数值类型
- `INT` / `INTEGER` - 整数（-2147483648 到 2147483647）
- `BIGINT` - 大整数
- `DECIMAL(M,D)` - 定点数（M是总位数，D是小数位数）
- `FLOAT` / `DOUBLE` - 浮点数

### 字符串类型
- `CHAR(n)` - 定长字符串
- `VARCHAR(n)` - 变长字符串
- `TEXT` - 长文本
- `ENUM('值1', '值2', ...)` - 枚举类型

### 日期时间类型
- `DATE` - 日期（YYYY-MM-DD）
- `TIME` - 时间（HH:MM:SS）
- `DATETIME` - 日期时间
- `TIMESTAMP` - 时间戳

### 其他类型
- `BOOLEAN` / `BOOL` - 布尔值（实际存储为 0 或 1）
- `BLOB` - 二进制大对象

## SQL 书写规范

### 1. 命名规范
- 表名、列名使用小写字母和下划线
- 表名使用复数形式或具有描述性
- 避免使用 SQL 关键字作为名称

```sql
-- ✅ 好的命名
CREATE TABLE students (...);
CREATE TABLE course_enrollments (...);

-- ❌ 避免的命名
CREATE TABLE Student (...);
CREATE TABLE select (...);  -- select 是关键字
```

### 2. 格式规范
- SQL 关键字大写（可选，但建议统一风格）
- 每个子句独立一行
- 适当使用缩进

```sql
-- ✅ 清晰的格式
SELECT 
    name, 
    email, 
    gpa
FROM students
WHERE gpa > 3.5
ORDER BY name;

-- ❌ 不清晰的格式
select name,email,gpa from students where gpa>3.5 order by name;
```

### 3. 注释规范
```sql
-- 单行注释

/*
多行注释
可以跨越多行
*/

SELECT name  -- 行尾注释
FROM students;
```

## SQL 执行顺序

虽然 SQL 的书写顺序是：
```
SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT
```

但实际执行顺序是：
```
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
```

理解执行顺序对写复杂查询很重要！

## 学习建议

### 1. 循序渐进
- 从基础语法开始
- 先学会增删改查
- 再学习连接和聚合
- 最后学习优化和设计

### 2. 多动手练习
- 不要只看不练
- 每个知识点都要实际操作
- 尝试解决实际问题

### 3. 理解而非记忆
- 理解 SQL 的逻辑
- 知道为什么这样写
- 能够举一反三

### 4. 建立知识体系
- 整理笔记
- 总结常用模式
- 记录遇到的问题

## 常用命令速查

### 数据库操作
```sql
-- 查看所有数据库
SHOW DATABASES;

-- 创建数据库
CREATE DATABASE db_name;

-- 使用数据库
USE db_name;

-- 删除数据库
DROP DATABASE db_name;
```

### 表操作
```sql
-- 查看所有表
SHOW TABLES;

-- 查看表结构
DESCRIBE table_name;
DESC table_name;

-- 查看建表语句
SHOW CREATE TABLE table_name;
```

### 数据操作
```sql
-- 查询
SELECT * FROM table_name;

-- 插入
INSERT INTO table_name (col1, col2) VALUES (val1, val2);

-- 更新
UPDATE table_name SET col1 = val1 WHERE condition;

-- 删除
DELETE FROM table_name WHERE condition;
```

## 下一步学习

- [ ] 完成基础语法练习
- [ ] 掌握查询操作
- [ ] 学习数据操作
- [ ] 进阶到多表连接
- [ ] 了解索引和优化
- [ ] 实战项目练习

---

**更新时间：** 2025-11-19
