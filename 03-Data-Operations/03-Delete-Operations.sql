-- =============================================
-- 03-数据操作 / 03-删除操作 (DELETE)
-- =============================================

-- DELETE 语句用于删除表中的记录

-- =============================================
-- 1. 基本删除语法
-- =============================================

-- 删除单条记录
DELETE FROM students
WHERE student_id = 100;

-- ⚠️ 警告：不加 WHERE 条件会删除所有记录！
-- DELETE FROM students;  -- 危险操作！会清空整个表

-- ⚠️ 推荐：删除前先查询确认
SELECT * FROM students WHERE student_id = 100;
-- 确认后再删除
DELETE FROM students WHERE student_id = 100;

-- =============================================
-- 2. 基于条件的删除
-- =============================================

-- 单条件删除
DELETE FROM enrollments
WHERE grade < 40;

-- 多条件删除 (AND)
DELETE FROM students
WHERE gender = 'M' AND enrollment_date < '2020-01-01';

-- 多条件删除 (OR)
DELETE FROM enrollments
WHERE grade IS NULL OR enrollment_date < '2021-01-01';

-- BETWEEN 条件
DELETE FROM enrollments
WHERE grade BETWEEN 0 AND 30;

-- IN 条件
DELETE FROM students
WHERE student_id IN (101, 102, 103);

-- LIKE 模糊匹配
DELETE FROM students
WHERE email LIKE '%temp%';

-- NOT 条件
DELETE FROM enrollments
WHERE grade NOT BETWEEN 60 AND 100;

-- =============================================
-- 3. 使用子查询删除
-- =============================================

-- 删除符合子查询条件的记录
DELETE FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE grade < 50
    GROUP BY student_id
    HAVING COUNT(*) >= 3
);

-- 删除没有选课记录的学生
DELETE FROM students
WHERE student_id NOT IN (
    SELECT DISTINCT student_id
    FROM enrollments
);

-- 删除重复记录（保留最早的一条）
DELETE FROM students
WHERE student_id NOT IN (
    SELECT MIN(student_id)
    FROM students
    GROUP BY email
);

-- =============================================
-- 4. 关联其他表删除
-- =============================================

-- 删除某个系的所有课程
DELETE FROM courses
WHERE department_id = (
    SELECT department_id 
    FROM departments 
    WHERE name = 'Test Department'
);

-- 删除某个老师教授的所有课程的选课记录
DELETE FROM enrollments
WHERE course_id IN (
    SELECT course_id
    FROM courses
    WHERE teacher_id = 5
);

-- =============================================
-- 5. 限制删除行数（SQLite）
-- =============================================

-- SQLite 使用 LIMIT 限制删除行数（需要编译时启用）
-- DELETE FROM students
-- WHERE gender = 'M'
-- ORDER BY birth_date
-- LIMIT 5;

-- =============================================
-- 6. 删除表中所有数据
-- =============================================

-- 方式 1: DELETE（慢，会记录日志，可回滚）
DELETE FROM students_backup;

-- 方式 2: 重新创建表（快，不可回滚）
DROP TABLE IF EXISTS students_backup;
CREATE TABLE students_backup (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    gender TEXT,
    birth_date TEXT
);

-- =============================================
-- 7. 安全删除实践
-- =============================================

-- 步骤 1: 先备份要删除的数据
CREATE TABLE IF NOT EXISTS deleted_students AS
SELECT * FROM students WHERE student_id > 50;

-- 步骤 2: 查询确认要删除的记录
SELECT * FROM students WHERE student_id > 50;

-- 步骤 3: 执行删除
DELETE FROM students WHERE student_id > 50;

-- 步骤 4: 验证删除结果
SELECT COUNT(*) FROM students;
SELECT * FROM deleted_students;  -- 查看备份

-- =============================================
-- 8. 使用事务确保安全
-- =============================================

-- 开始事务
BEGIN TRANSACTION;

-- 执行删除操作
DELETE FROM enrollments WHERE grade < 40;

-- 检查删除结果
SELECT COUNT(*) FROM enrollments WHERE grade < 40;

-- 如果正确，提交事务
COMMIT;

-- 如果有问题，回滚事务
-- ROLLBACK;

-- =============================================
-- 9. 级联删除相关数据
-- =============================================

-- 先删除子表数据（enrollments）
DELETE FROM enrollments
WHERE student_id = 1;

-- 再删除主表数据（students）
DELETE FROM students
WHERE student_id = 1;

-- =============================================
-- 10. 常见删除场景
-- =============================================

-- 场景 1: 清理过期数据
DELETE FROM enrollments
WHERE enrollment_date < date('now', '-5 years');

-- 场景 2: 删除重复记录
DELETE FROM students
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM students
    GROUP BY email
);

-- 场景 3: 删除孤立记录（没有关联的记录）
DELETE FROM enrollments
WHERE student_id NOT IN (SELECT student_id FROM students);

-- 场景 4: 条件批量删除
DELETE FROM students
WHERE student_id IN (
    SELECT s.student_id
    FROM students s
    LEFT JOIN enrollments e ON s.student_id = e.student_id
    WHERE e.student_id IS NULL
    AND s.enrollment_date < '2020-01-01'
);

-- 场景 5: 删除测试数据
DELETE FROM students
WHERE name LIKE 'Test%' OR email LIKE '%test%';

-- =============================================
-- 11. 软删除（逻辑删除）
-- =============================================

-- 添加删除标记列
-- ALTER TABLE students ADD COLUMN is_deleted INTEGER DEFAULT 0;
-- ALTER TABLE students ADD COLUMN deleted_at TEXT;

-- 软删除：标记为已删除而不是真正删除
UPDATE students
SET is_deleted = 1,
    deleted_at = datetime('now')
WHERE student_id = 10;

-- 查询时排除已删除的记录
SELECT * FROM students WHERE is_deleted = 0;

-- 真正删除已标记的记录（定期清理）
DELETE FROM students
WHERE is_deleted = 1 
AND deleted_at < date('now', '-30 days');

-- =============================================
-- 12. 删除性能优化
-- =============================================

-- 对于大量删除，使用事务批量处理
BEGIN TRANSACTION;

DELETE FROM enrollments WHERE enrollment_date < '2020-01-01';
DELETE FROM students WHERE student_id NOT IN (SELECT student_id FROM enrollments);

COMMIT;

-- 对于清空表，重建表更快
DROP TABLE IF EXISTS temp_table;
CREATE TABLE temp_table (/* columns */);

-- =============================================
-- 练习题
-- =============================================

-- 练习 1: 删除所有成绩低于 50 分的选课记录

-- 练习 2: 删除所有没有选课记录的学生（提示：使用 NOT IN 子查询）

-- 练习 3: 删除重复的邮箱，只保留 student_id 最小的那条记录

-- 练习 4: 删除所有在 "Test Department" 系的课程（提示：需要关联 departments 表）

-- 练习 5: 使用事务删除学生 ID 为 5 的学生及其所有选课记录
-- 如果选课记录超过 10 条则回滚，否则提交

-- 练习 6: 实现软删除：标记所有 2020 年之前入学的学生为已删除

-- =============================================
-- 查看删除结果
-- =============================================

SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_enrollments FROM enrollments;
SELECT * FROM students ORDER BY student_id DESC LIMIT 5;
