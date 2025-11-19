-- ==========================================
-- 01. 创建数据库和表
-- 练习日期: 2025-11-19
-- ==========================================

-- 1. 创建数据库
-- ==========================================

-- 创建一个名为 school 的数据库
CREATE DATABASE IF NOT EXISTS school;

-- 查看所有数据库
SHOW DATABASES;

-- 使用 school 数据库
USE school;

-- 删除数据库（谨慎使用）
-- DROP DATABASE IF EXISTS school;


-- 2. 创建表
-- ==========================================

-- 创建学生表
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,  -- 学生ID（主键，自增）
    name VARCHAR(50) NOT NULL,                  -- 姓名（不能为空）
    gender ENUM('男', '女') NOT NULL,           -- 性别
    birth_date DATE,                            -- 出生日期
    email VARCHAR(100) UNIQUE,                  -- 邮箱（唯一）
    phone VARCHAR(20),                          -- 电话
    address VARCHAR(200),                       -- 地址
    enrollment_date DATE DEFAULT CURRENT_DATE,  -- 入学日期（默认当前日期）
    gpa DECIMAL(3, 2) CHECK (gpa >= 0 AND gpa <= 4.0)  -- GPA（0-4.0之间）
);

-- 创建课程表
CREATE TABLE IF NOT EXISTS courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,   -- 课程ID
    course_name VARCHAR(100) NOT NULL,          -- 课程名称
    credits INT NOT NULL,                       -- 学分
    teacher VARCHAR(50),                        -- 授课老师
    department VARCHAR(50)                      -- 所属院系
);

-- 创建选课表（多对多关系）
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,  -- 选课记录ID
    student_id INT,                                -- 学生ID（外键）
    course_id INT,                                 -- 课程ID（外键）
    semester VARCHAR(20),                          -- 学期
    grade DECIMAL(5, 2),                          -- 成绩
    enrollment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 选课时间
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);


-- 3. 查看表结构
-- ==========================================

-- 查看所有表
SHOW TABLES;

-- 查看表结构
DESCRIBE students;
DESC courses;
SHOW COLUMNS FROM enrollments;

-- 查看建表语句
SHOW CREATE TABLE students;


-- 4. 修改表结构
-- ==========================================

-- 添加新列
ALTER TABLE students 
ADD COLUMN class_name VARCHAR(30) AFTER name;

-- 修改列定义
ALTER TABLE students 
MODIFY COLUMN phone VARCHAR(30);

-- 修改列名
ALTER TABLE students 
CHANGE COLUMN class_name class VARCHAR(30);

-- 删除列
ALTER TABLE students 
DROP COLUMN address;

-- 添加索引
ALTER TABLE students 
ADD INDEX idx_name (name);

-- 添加唯一约束
ALTER TABLE students 
ADD UNIQUE KEY uk_email (email);


-- 5. 删除表
-- ==========================================

-- 删除表（谨慎使用）
-- DROP TABLE IF EXISTS enrollments;

-- 清空表数据但保留表结构
-- TRUNCATE TABLE students;


-- ==========================================
-- 练习题
-- ==========================================

/*
练习1: 创建一个 teachers 表，包含以下字段：
- teacher_id (主键，自增)
- name (姓名，不能为空)
- department (院系)
- title (职称: 教授/副教授/讲师)
- hire_date (入职日期)
- salary (薪资)
*/

-- 在这里写你的答案




/*
练习2: 为 teachers 表添加一个 email 字段，要求唯一且不能为空
*/

-- 在这里写你的答案




/*
练习3: 创建一个 departments 表，包含：
- dept_id (主键)
- dept_name (院系名称)
- building (所在楼栋)
- budget (预算)
*/

-- 在这里写你的答案




-- ==========================================
-- 学习笔记
-- ==========================================

/*
重要概念：
1. 主键 (PRIMARY KEY): 唯一标识每一行数据
2. 外键 (FOREIGN KEY): 建立表之间的关联关系
3. 自增 (AUTO_INCREMENT): 自动生成递增的数字
4. 非空约束 (NOT NULL): 字段值不能为空
5. 唯一约束 (UNIQUE): 字段值不能重复
6. 默认值 (DEFAULT): 未提供值时使用的默认值
7. 检查约束 (CHECK): 限制字段值的范围

常用数据类型：
- INT: 整数
- VARCHAR(n): 可变长度字符串
- DATE: 日期 (YYYY-MM-DD)
- DATETIME/TIMESTAMP: 日期时间
- DECIMAL(m,n): 定点数（适合存储金额等）
- ENUM: 枚举类型
- TEXT: 长文本

遇到的问题：


解决方案：


*/
