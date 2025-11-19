-- ==========================================
-- 02. 条件查询 (WHERE)
-- 练习日期: 
-- ==========================================

USE school;

-- 1. 比较运算符
-- ==========================================

-- 查询 GPA 大于 3.8 的学生
SELECT * FROM students WHERE gpa > 3.8;

-- 查询学分等于4的课程
SELECT * FROM courses WHERE credits = 4;

-- 查询成绩大于等于90分的选课记录
SELECT * FROM enrollments WHERE grade >= 90;

-- 查询 GPA 不等于 3.5 的学生
SELECT * FROM students WHERE gpa != 3.5;
-- 或者使用 <>
SELECT * FROM students WHERE gpa <> 3.5;


-- 2. 逻辑运算符 (AND, OR, NOT)
-- ==========================================

-- AND：同时满足多个条件
-- 查询性别为男且 GPA 大于 3.6 的学生
SELECT * FROM students 
WHERE gender = '男' AND gpa > 3.6;

-- OR：满足任一条件
-- 查询 GPA 大于 3.9 或者性别为女的学生
SELECT * FROM students 
WHERE gpa > 3.9 OR gender = '女';

-- NOT：取反
-- 查询性别不是男的学生
SELECT * FROM students WHERE NOT gender = '男';

-- 组合使用（注意使用括号）
-- 查询（GPA > 3.8 且性别为女）或（GPA > 3.9 且性别为男）的学生
SELECT * FROM students 
WHERE (gpa > 3.8 AND gender = '女') OR (gpa > 3.9 AND gender = '男');


-- 3. 范围查询 (BETWEEN)
-- ==========================================

-- 查询 GPA 在 3.5 到 3.8 之间的学生
SELECT * FROM students 
WHERE gpa BETWEEN 3.5 AND 3.8;

-- 等价于
SELECT * FROM students 
WHERE gpa >= 3.5 AND gpa <= 3.8;

-- 查询出生日期在某个范围内的学生
SELECT * FROM students 
WHERE birth_date BETWEEN '2000-01-01' AND '2000-12-31';

-- NOT BETWEEN
SELECT * FROM students 
WHERE gpa NOT BETWEEN 3.0 AND 3.5;


-- 4. 集合查询 (IN)
-- ==========================================

-- 查询院系为计算机科学或数学系的课程
SELECT * FROM courses 
WHERE department IN ('计算机科学', '数学系');

-- 等价于
SELECT * FROM courses 
WHERE department = '计算机科学' OR department = '数学系';

-- 查询学分为3或4的课程
SELECT * FROM courses 
WHERE credits IN (3, 4);

-- NOT IN
SELECT * FROM courses 
WHERE department NOT IN ('外语学院', '物理系');


-- 5. 模糊查询 (LIKE)
-- ==========================================

-- % 表示任意多个字符（包括0个）
-- 查询姓名中包含"三"的学生
SELECT * FROM students WHERE name LIKE '%三%';

-- 查询姓张的学生
SELECT * FROM students WHERE name LIKE '张%';

-- 查询姓名以"六"结尾的学生
SELECT * FROM students WHERE name LIKE '%六';

-- _ 表示单个字符
-- 查询姓名是两个字的学生
SELECT * FROM students WHERE name LIKE '__';

-- 查询姓名是三个字，中间字是"十"的学生
SELECT * FROM students WHERE name LIKE '_十_';

-- NOT LIKE
SELECT * FROM students WHERE name NOT LIKE '张%';

-- 转义特殊字符
-- 查询课程名称中包含下划线的（假设有的话）
SELECT * FROM courses WHERE course_name LIKE '%\_%';


-- 6. NULL 值查询
-- ==========================================

-- 查询邮箱为空的学生
SELECT * FROM students WHERE email IS NULL;

-- 查询邮箱不为空的学生
SELECT * FROM students WHERE email IS NOT NULL;

-- 注意：不能使用 = NULL 或 != NULL
-- ❌ 错误写法
-- SELECT * FROM students WHERE email = NULL;


-- 7. 日期查询
-- ==========================================

-- 查询2000年出生的学生
SELECT * FROM students 
WHERE YEAR(birth_date) = 2000;

-- 查询上半年出生的学生
SELECT * FROM students 
WHERE MONTH(birth_date) <= 6;

-- 查询今年入学的学生
SELECT * FROM students 
WHERE YEAR(enrollment_date) = YEAR(CURRENT_DATE);


-- 8. 正则表达式 (REGEXP)
-- ==========================================

-- 查询姓名以"张"或"王"开头的学生
SELECT * FROM students 
WHERE name REGEXP '^[张王]';

-- 查询姓名包含数字的学生
SELECT * FROM students 
WHERE name REGEXP '[0-9]';

-- 查询邮箱格式正确的学生（简单验证）
SELECT * FROM students 
WHERE email REGEXP '^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+$';


-- 9. 复杂条件组合
-- ==========================================

-- 查询计算机科学系的4学分课程
SELECT * FROM courses 
WHERE department = '计算机科学' AND credits = 4;

-- 查询 GPA 在3.5以上的女生，或者 GPA 在3.8以上的男生
SELECT * FROM students 
WHERE (gender = '女' AND gpa > 3.5) 
   OR (gender = '男' AND gpa > 3.8);

-- 查询姓张、李、王且 GPA 大于3.6的学生
SELECT * FROM students 
WHERE name LIKE '张%' OR name LIKE '李%' OR name LIKE '王%'
  AND gpa > 3.6;

-- 更清晰的写法
SELECT * FROM students 
WHERE (name LIKE '张%' OR name LIKE '李%' OR name LIKE '王%')
  AND gpa > 3.6;


-- ==========================================
-- 练习题
-- ==========================================

/*
练习1: 查询 GPA 在 3.6 到 3.9 之间的所有学生信息
*/

-- 在这里写你的答案




/*
练习2: 查询计算机科学系或数学系的所有3学分或4学分课程
*/

-- 在这里写你的答案




/*
练习3: 查询所有2001年出生的女生
*/

-- 在这里写你的答案




/*
练习4: 查询姓名包含"十"字的学生，且 GPA 大于 3.5
*/

-- 在这里写你的答案




/*
练习5: 查询有电话号码但没有邮箱的学生
*/

-- 在这里写你的答案




/*
练习6: 查询成绩在85-95分之间的选课记录，显示学生ID、课程ID和成绩
*/

-- 在这里写你的答案




/*
练习7: 查询所有不是计算机科学系和数学系的课程
*/

-- 在这里写你的答案




-- ==========================================
-- 学习笔记
-- ==========================================

/*
WHERE 子句运算符总结：

比较运算符：
=, !=, <>, <, >, <=, >=

逻辑运算符：
AND, OR, NOT

范围和集合：
BETWEEN ... AND ...
IN (值1, 值2, ...)
NOT IN (...)

模式匹配：
LIKE '模式'
- % : 匹配任意多个字符
- _ : 匹配单个字符
REGEXP '正则表达式'

NULL 检查：
IS NULL
IS NOT NULL

运算符优先级（从高到低）：
1. ()
2. NOT
3. 比较运算符
4. AND
5. OR

注意事项：
1. 字符串比较区分大小写（取决于字符集）
2. 日期比较要注意格式
3. NULL 不能用 = 或 != 比较
4. 使用括号明确逻辑关系
5. LIKE 性能较低，谨慎使用

遇到的问题：


解决方案：


*/
