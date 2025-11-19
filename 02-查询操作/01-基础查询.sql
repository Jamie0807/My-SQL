-- ==========================================
-- 01. 基础查询 (SELECT)
-- 练习日期: 
-- ==========================================

USE school;

-- 1. 查询所有列
-- ==========================================

-- 查询学生表的所有数据
SELECT * FROM students;

-- 查询课程表的所有数据
SELECT * FROM courses;


-- 2. 查询指定列
-- ==========================================

-- 查询学生的姓名和邮箱
SELECT name, email FROM students;

-- 查询课程名称和学分
SELECT course_name, credits FROM courses;

-- 查询学生姓名、性别和GPA
SELECT name, gender, gpa FROM students;


-- 3. 使用别名 (AS)
-- ==========================================

-- 为列起别名
SELECT 
    name AS '姓名',
    gender AS '性别',
    gpa AS '平均绩点'
FROM students;

-- 为表起别名
SELECT 
    s.name,
    s.email
FROM students AS s;

-- AS 关键字可以省略
SELECT 
    name 姓名,
    email 邮箱
FROM students s;


-- 4. 查询去重 (DISTINCT)
-- ==========================================

-- 查询所有不同的性别
SELECT DISTINCT gender FROM students;

-- 查询所有不同的院系
SELECT DISTINCT department FROM courses;

-- 查询不同的学期
SELECT DISTINCT semester FROM enrollments;


-- 5. 限制返回行数 (LIMIT)
-- ==========================================

-- 查询前5个学生
SELECT * FROM students LIMIT 5;

-- 查询前3门课程
SELECT * FROM courses LIMIT 3;

-- 分页：跳过前5条，返回接下来的5条
SELECT * FROM students LIMIT 5, 5;
-- 或者使用 OFFSET 关键字（更清晰）
SELECT * FROM students LIMIT 5 OFFSET 5;


-- 6. 计算和表达式
-- ==========================================

-- 计算学生年龄（简化计算）
SELECT 
    name,
    birth_date,
    YEAR(CURRENT_DATE) - YEAR(birth_date) AS age
FROM students;

-- 计算课程总学时（假设1学分=16学时）
SELECT 
    course_name,
    credits,
    credits * 16 AS total_hours
FROM courses;

-- GPA 转换为百分制（假设 GPA 4.0 = 100分）
SELECT 
    name,
    gpa,
    gpa * 25 AS score
FROM students;


-- 7. 字符串拼接
-- ==========================================

-- 拼接姓名和邮箱
SELECT 
    CONCAT(name, ' (', email, ')') AS student_info
FROM students;

-- 格式化输出
SELECT 
    CONCAT('学生：', name, '，GPA：', gpa) AS description
FROM students;


-- 8. 条件表达式 (CASE)
-- ==========================================

-- 根据GPA分等级
SELECT 
    name,
    gpa,
    CASE
        WHEN gpa >= 3.8 THEN '优秀'
        WHEN gpa >= 3.5 THEN '良好'
        WHEN gpa >= 3.0 THEN '中等'
        WHEN gpa >= 2.5 THEN '及格'
        ELSE '待提高'
    END AS grade_level
FROM students;

-- 根据学分判断课程类型
SELECT 
    course_name,
    credits,
    CASE
        WHEN credits >= 4 THEN '主干课程'
        WHEN credits = 3 THEN '必修课程'
        ELSE '选修课程'
    END AS course_type
FROM courses;


-- 9. NULL 值处理
-- ==========================================

-- 使用 IFNULL 提供默认值
SELECT 
    name,
    IFNULL(phone, '未提供') AS phone
FROM students;

-- 使用 COALESCE（返回第一个非NULL值）
SELECT 
    name,
    COALESCE(email, phone, '无联系方式') AS contact
FROM students;

-- 使用 NULLIF（如果两个值相等则返回NULL）
SELECT 
    name,
    NULLIF(gpa, 0) AS valid_gpa
FROM students;


-- 10. 常用函数
-- ==========================================

-- 字符串函数
SELECT 
    name,
    UPPER(name) AS uppercase,          -- 转大写
    LOWER(name) AS lowercase,          -- 转小写
    LENGTH(name) AS name_length,       -- 字符串长度
    SUBSTRING(name, 1, 1) AS first_char  -- 截取子串
FROM students;

-- 日期函数
SELECT 
    name,
    birth_date,
    YEAR(birth_date) AS birth_year,    -- 年份
    MONTH(birth_date) AS birth_month,  -- 月份
    DAY(birth_date) AS birth_day       -- 日期
FROM students;

-- 数学函数
SELECT 
    course_name,
    credits,
    ROUND(credits * 1.5, 2) AS adjusted_credits,  -- 四舍五入
    CEILING(credits * 1.2) AS ceiling_credits,    -- 向上取整
    FLOOR(credits * 0.8) AS floor_credits         -- 向下取整
FROM courses;


-- ==========================================
-- 练习题
-- ==========================================

/*
练习1: 查询所有学生的姓名和出生日期，按出生日期显示年龄
*/

-- 在这里写你的答案




/*
练习2: 查询所有课程，显示课程名称和学分，并标注是否为"高学分课程"（4学分及以上）
提示：使用 CASE WHEN
*/

-- 在这里写你的答案




/*
练习3: 查询前10名学生的姓名、邮箱，如果邮箱为空则显示"暂无邮箱"
*/

-- 在这里写你的答案




/*
练习4: 查询所有学生，显示"姓名 - 性别"的格式，例如"张三 - 男"
*/

-- 在这里写你的答案




/*
练习5: 查询所有不同的院系，并统计每个院系的数量（暂时用 COUNT(*) 和 GROUP BY）
*/

-- 在这里写你的答案




-- ==========================================
-- 学习笔记
-- ==========================================

/*
SELECT 基本语法：
SELECT [DISTINCT] 列名1, 列名2, ...
FROM 表名
[WHERE 条件]
[ORDER BY 列名 [ASC|DESC]]
[LIMIT 数量 [OFFSET 偏移量]]

重要概念：
1. * 表示所有列
2. AS 用于设置别名
3. DISTINCT 用于去重
4. LIMIT 用于限制返回行数
5. CONCAT 用于字符串拼接
6. CASE WHEN 用于条件判断

常用函数：
- 字符串：UPPER, LOWER, LENGTH, SUBSTRING, CONCAT
- 日期：YEAR, MONTH, DAY, DATE_FORMAT, DATEDIFF
- 数学：ROUND, CEILING, FLOOR, ABS
- 其他：IFNULL, COALESCE, NULLIF

遇到的问题：


解决方案：


*/
