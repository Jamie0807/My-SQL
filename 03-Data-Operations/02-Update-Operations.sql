-- =============================================
-- 03-数据操作 / 02-更新操作 (UPDATE)
-- =============================================

-- UPDATE 语句用于修改表中的现有记录

-- =============================================
-- 1. 基本更新语法
-- =============================================

-- 更新单个字段
UPDATE students
SET email = 'john.newemail@email.com'
WHERE student_id = 1;

-- 更新多个字段
UPDATE students
SET email = 'emma.updated@email.com',
    phone = '555-1234'
WHERE student_id = 2;

-- ⚠️ 警告：不加 WHERE 条件会更新所有记录！
-- UPDATE students SET gender = 'M';  -- 危险操作！

-- =============================================
-- 2. 使用表达式更新
-- =============================================

-- 使用计算表达式
UPDATE enrollments
SET grade = grade + 5
WHERE grade < 60;

-- 字符串拼接
UPDATE students
SET email = LOWER(REPLACE(name, ' ', '.')) || '@school.edu'
WHERE email IS NULL;

-- 使用函数
UPDATE students
SET name = UPPER(name)
WHERE student_id = 3;

-- =============================================
-- 3. 基于条件的更新
-- =============================================

-- 单条件
UPDATE enrollments
SET grade = 85
WHERE student_id = 1 AND course_id = 1;

-- 多条件 (AND)
UPDATE students
SET phone = '555-0000'
WHERE gender = 'M' AND birth_date < '2003-01-01';

-- 多条件 (OR)
UPDATE enrollments
SET grade = grade + 10
WHERE grade < 50 OR enrollment_date < '2022-01-01';

-- BETWEEN 条件
UPDATE enrollments
SET grade = 75
WHERE grade BETWEEN 70 AND 79;

-- IN 条件
UPDATE students
SET phone = 'N/A'
WHERE student_id IN (5, 6, 7);

-- LIKE 模糊匹配
UPDATE students
SET email = LOWER(email)
WHERE email LIKE '%@EMAIL.COM';

-- =============================================
-- 4. 使用子查询更新
-- =============================================

-- 根据其他表的数据更新
UPDATE students
SET email = 'top.student@email.com'
WHERE student_id IN (
    SELECT student_id 
    FROM enrollments 
    WHERE grade >= 95
    GROUP BY student_id
);

-- 使用关联子查询
UPDATE enrollments
SET grade = (
    SELECT AVG(e2.grade)
    FROM enrollments e2
    WHERE e2.course_id = enrollments.course_id
)
WHERE grade IS NULL;

-- =============================================
-- 5. CASE 条件更新
-- =============================================

-- 根据不同条件设置不同值
UPDATE enrollments
SET grade = CASE
    WHEN grade >= 90 THEN grade + 5
    WHEN grade >= 80 THEN grade + 3
    WHEN grade >= 70 THEN grade + 2
    ELSE grade + 1
END
WHERE enrollment_date >= '2023-01-01';

-- 多列 CASE 更新
UPDATE students
SET 
    phone = CASE 
        WHEN phone IS NULL THEN '000-0000'
        ELSE phone
    END,
    email = CASE
        WHEN email IS NULL THEN name || '@default.com'
        ELSE email
    END
WHERE student_id > 10;

-- =============================================
-- 6. 批量更新优化
-- =============================================

-- 使用事务进行批量更新
BEGIN TRANSACTION;

UPDATE students SET phone = '555-1111' WHERE student_id = 1;
UPDATE students SET phone = '555-2222' WHERE student_id = 2;
UPDATE students SET phone = '555-3333' WHERE student_id = 3;

COMMIT;

-- =============================================
-- 7. 更新日期和时间
-- =============================================

-- 更新为当前日期
UPDATE students
SET enrollment_date = date('now')
WHERE enrollment_date IS NULL;

-- 日期计算
UPDATE students
SET enrollment_date = date(birth_date, '+18 years')
WHERE enrollment_date IS NULL;

-- =============================================
-- 8. 常见更新场景
-- =============================================

-- 场景1: 修正错误数据
UPDATE students
SET gender = 'F'
WHERE name = 'Emma Johnson' AND gender = 'M';

-- 场景2: 标准化数据格式
UPDATE students
SET phone = REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', '')
WHERE phone LIKE '%-%';

-- 场景3: 填充默认值
UPDATE students
SET phone = 'Not Provided'
WHERE phone IS NULL OR phone = '';

-- 场景4: 根据规则批量修改
UPDATE enrollments
SET grade = 0
WHERE grade IS NULL;

-- 场景5: 数据迁移/转换
UPDATE students
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;

-- =============================================
-- 9. 安全更新实践
-- =============================================

-- 在更新前先查询确认影响的记录
SELECT * FROM students WHERE student_id = 1;

-- 然后再更新
UPDATE students
SET email = 'confirmed@email.com'
WHERE student_id = 1;

-- 验证更新结果
SELECT * FROM students WHERE student_id = 1;

-- =============================================
-- 10. 限制更新行数（SQLite 需要启用）
-- =============================================

-- SQLite 中使用 LIMIT（需要编译时启用）
-- UPDATE students
-- SET phone = '555-9999'
-- WHERE gender = 'M'
-- LIMIT 5;

-- =============================================
-- 练习题
-- =============================================

-- 练习 1: 将所有女生的邮箱域名改为 @girls.edu
-- (提示: 使用 SUBSTR 或 REPLACE 处理邮箱)

-- 练习 2: 将所有低于 60 分的成绩提高到 60 分

-- 练习 3: 使用 CASE 语句，根据成绩更新评级：
-- 90-100: 'A', 80-89: 'B', 70-79: 'C', 60-69: 'D', <60: 'F'
-- (需要先添加 grade_level 列)

-- 练习 4: 更新所有在 2003 年出生的学生的手机号为 '555-2003'

-- 练习 5: 将选修了 "Database Systems" 课程的学生成绩提高 5 分
-- (提示: 需要使用子查询关联 courses 表)

-- =============================================
-- 查看更新结果
-- =============================================

SELECT * FROM students LIMIT 10;
SELECT * FROM enrollments ORDER BY grade DESC LIMIT 10;
