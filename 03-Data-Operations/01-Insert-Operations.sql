-- =============================================
-- 03-数据操作 / 01-插入操作 (INSERT)
-- =============================================

-- INSERT INTO 语句用于向表中插入新记录

-- =============================================
-- 1. 单行插入
-- =============================================

-- 插入完整记录（指定所有列）
INSERT INTO students (student_id, name, gender, birth_date, email, phone, enrollment_date)
VALUES (16, 'Robert Brown', 'M', '2003-08-20', 'robert.brown@email.com', '555-9999', '2022-09-01');

-- 插入部分列（其他列使用默认值或 NULL）
INSERT INTO students (name, gender, birth_date)
VALUES ('Sophia White', 'F', '2004-02-15');

-- 不指定列名（必须按表定义顺序提供所有值）
INSERT INTO students 
VALUES (18, 'Lucas Green', 'M', '2003-11-30', 'lucas.green@email.com', '555-8888', '2022-09-01');

-- =============================================
-- 2. 多行插入
-- =============================================

-- 一次插入多条记录（推荐方式，效率更高）
INSERT INTO students (name, gender, birth_date, email, enrollment_date)
VALUES 
    ('Olivia Black', 'F', '2004-03-12', 'olivia.black@email.com', '2022-09-01'),
    ('William Blue', 'M', '2003-07-25', 'william.blue@email.com', '2022-09-01'),
    ('Ava Gray', 'F', '2004-01-18', 'ava.gray@email.com', '2022-09-01');

-- =============================================
-- 3. 从其他表插入数据
-- =============================================

-- 创建临时表
CREATE TABLE IF NOT EXISTS students_backup (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    gender TEXT CHECK(gender IN ('M', 'F')),
    birth_date TEXT,
    email TEXT UNIQUE,
    phone TEXT,
    enrollment_date TEXT
);

-- 从 students 表复制数据到备份表
INSERT INTO students_backup (name, gender, birth_date, email, phone, enrollment_date)
SELECT name, gender, birth_date, email, phone, enrollment_date
FROM students
WHERE enrollment_date >= '2022-01-01';

-- =============================================
-- 4. 插入并返回生成的 ID
-- =============================================

-- SQLite 使用 last_insert_rowid() 获取最后插入的 ID
INSERT INTO students (name, gender, birth_date)
VALUES ('Emma Red', 'F', '2004-05-20');

SELECT last_insert_rowid() AS new_student_id;

-- =============================================
-- 5. 处理重复键冲突
-- =============================================

-- SQLite 使用 INSERT OR REPLACE（如果主键或唯一键冲突，删除旧记录并插入新记录）
INSERT OR REPLACE INTO students (student_id, name, gender, birth_date, email)
VALUES (1, 'John Smith Updated', 'M', '2003-05-15', 'john.updated@email.com');

-- INSERT OR IGNORE（如果冲突，忽略新记录）
INSERT OR IGNORE INTO students (email, name, gender, birth_date)
VALUES ('john.smith@email.com', 'John Duplicate', 'M', '2003-05-15');

-- =============================================
-- 6. 使用 DEFAULT 关键字
-- =============================================

-- 创建一个带默认值的表示例
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    order_date TEXT DEFAULT (date('now')),
    status TEXT DEFAULT 'pending',
    total_amount REAL DEFAULT 0.00
);

-- 使用 DEFAULT 关键字让列使用默认值
INSERT INTO orders (student_id, total_amount)
VALUES (1, 99.99);

-- 显式使用 DEFAULT
INSERT INTO orders (student_id, order_date, status, total_amount)
VALUES (2, DEFAULT, DEFAULT, 149.99);

-- =============================================
-- 7. 插入日期和时间
-- =============================================

-- SQLite 日期格式
INSERT INTO students (name, gender, birth_date, enrollment_date)
VALUES 
    ('Test Student 1', 'M', date('now'), date('now')),
    ('Test Student 2', 'F', '2004-06-15', datetime('now'));

-- =============================================
-- 8. 批量插入优化技巧
-- =============================================

-- 使用事务提高批量插入性能
BEGIN TRANSACTION;

INSERT INTO students (name, gender, birth_date) VALUES ('Student A', 'M', '2004-01-01');
INSERT INTO students (name, gender, birth_date) VALUES ('Student B', 'F', '2004-02-02');
INSERT INTO students (name, gender, birth_date) VALUES ('Student C', 'M', '2004-03-03');
-- ... 更多插入语句

COMMIT;

-- =============================================
-- 练习题
-- =============================================

-- 练习 1: 向 courses 表插入一门新课程
-- 课程名: "Machine Learning", 学分: 4, 学期: "Fall", 所属系: 1

-- 练习 2: 一次性插入 3 个新老师到 teachers 表
-- 使用你自己的数据

-- 练习 3: 创建一个临时表 top_students，将成绩大于等于 90 的学生信息复制进去
-- 包含 student_id, name, email

-- 练习 4: 向 enrollments 表插入选课记录，学生 ID 为 1，课程 ID 为 3
-- 如果已存在则忽略

-- 练习 5: 使用事务批量插入 5 门新课程到 courses 表

-- =============================================
-- 查看插入结果
-- =============================================

SELECT * FROM students ORDER BY student_id DESC LIMIT 10;
SELECT * FROM students_backup LIMIT 5;
SELECT * FROM orders;
