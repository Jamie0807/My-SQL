-- ==========================================
-- 示例数据库初始化脚本
-- 用于快速搭建练习环境
-- ==========================================

-- 创建数据库
DROP DATABASE IF EXISTS school;
CREATE DATABASE school CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE school;

-- ==========================================
-- 创建表结构
-- ==========================================

-- 学生表
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    gender ENUM('男', '女') NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    gpa DECIMAL(3, 2) CHECK (gpa >= 0 AND gpa <= 4.0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 课程表
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    teacher VARCHAR(50),
    department VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 选课表
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    grade DECIMAL(5, 2),
    enrollment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 教师表
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    title ENUM('教授', '副教授', '讲师', '助教') NOT NULL,
    hire_date DATE,
    salary DECIMAL(10, 2),
    email VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 院系表
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL UNIQUE,
    building VARCHAR(50),
    budget DECIMAL(12, 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================================
-- 插入示例数据
-- ==========================================

-- 插入学生数据
INSERT INTO students (name, gender, birth_date, email, phone, gpa, enrollment_date) VALUES
('张三', '男', '2000-05-15', 'zhangsan@example.com', '13800138000', 3.75, '2018-09-01'),
('李四', '女', '2001-03-20', 'lisi@example.com', '13800138001', 3.85, '2019-09-01'),
('王五', '男', '2000-08-10', 'wangwu@example.com', '13800138002', 3.50, '2018-09-01'),
('赵六', '女', '2001-01-05', 'zhaoliu@example.com', '13800138003', 3.92, '2019-09-01'),
('钱七', '男', '2000-11-25', 'qianqi@example.com', '13800138004', 3.60, '2018-09-01'),
('孙八', '女', '2001-06-15', 'sunba@example.com', '13800138005', 3.45, '2019-09-01'),
('周九', '男', '2000-12-01', 'zhoujiu@example.com', '13800138006', 3.78, '2018-09-01'),
('吴十', '女', '2001-04-18', 'wushi@example.com', '13800138007', 3.88, '2019-09-01'),
('郑十一', '男', '2000-07-22', 'zhengshiyi@example.com', '13800138008', 3.55, '2018-09-01'),
('王十二', '女', '2001-09-30', 'wangshier@example.com', '13800138009', 3.95, '2019-09-01'),
('刘十三', '男', '2000-02-14', 'liushisan@example.com', '13800138010', 3.42, '2018-09-01'),
('陈十四', '女', '2001-11-08', 'chenshisi@example.com', '13800138011', 3.82, '2019-09-01'),
('杨十五', '男', '2000-10-05', 'yangshiwu@example.com', '13800138012', 3.68, '2018-09-01'),
('黄十六', '女', '2001-08-20', 'huangshiliu@example.com', '13800138013', 3.91, '2019-09-01'),
('林十七', '男', '2000-03-12', 'linshiqi@example.com', '13800138014', 3.38, '2018-09-01');

-- 插入课程数据
INSERT INTO courses (course_name, credits, teacher, department) VALUES
('数据库原理', 4, '王教授', '计算机科学'),
('高等数学', 5, '李教授', '数学系'),
('大学英语', 3, '张老师', '外语学院'),
('数据结构', 4, '陈教授', '计算机科学'),
('线性代数', 4, '刘教授', '数学系'),
('操作系统', 4, '赵教授', '计算机科学'),
('计算机网络', 3, '周老师', '计算机科学'),
('离散数学', 3, '吴教授', '数学系'),
('Python编程', 3, '马老师', '计算机科学'),
('概率论', 4, '林教授', '数学系'),
('大学物理', 4, '徐教授', '物理系'),
('编译原理', 4, '郑教授', '计算机科学'),
('算法设计', 3, '钱老师', '计算机科学'),
('软件工程', 3, '孙教授', '计算机科学'),
('人工智能', 4, '周教授', '计算机科学');

-- 插入选课记录（成绩）
INSERT INTO enrollments (student_id, course_id, semester, grade) VALUES
-- 张三的成绩
(1, 1, '2024-秋季', 88.5), (1, 2, '2024-秋季', 92.0), (1, 4, '2024-秋季', 85.5),
-- 李四的成绩
(2, 1, '2024-秋季', 95.5), (2, 3, '2024-秋季', 87.0), (2, 2, '2024-秋季', 90.5),
-- 王五的成绩
(3, 2, '2024-秋季', 78.5), (3, 4, '2024-秋季', 85.0), (3, 6, '2024-秋季', 82.0),
-- 赵六的成绩
(4, 1, '2024-秋季', 91.5), (4, 5, '2024-秋季', 89.0), (4, 7, '2024-秋季', 93.5),
-- 钱七的成绩
(5, 3, '2024-秋季', 82.5), (5, 4, '2024-秋季', 88.0), (5, 8, '2024-秋季', 86.5),
-- 孙八的成绩
(6, 2, '2024-秋季', 76.5), (6, 5, '2024-秋季', 80.0), (6, 3, '2024-秋季', 84.5),
-- 周九的成绩
(7, 1, '2024-秋季', 89.5), (7, 6, '2024-秋季', 87.5), (7, 9, '2024-秋季', 91.0),
-- 吴十的成绩
(8, 4, '2024-秋季', 94.0), (8, 7, '2024-秋季', 90.5), (8, 2, '2024-秋季', 88.5),
-- 郑十一的成绩
(9, 3, '2024-秋季', 81.0), (9, 8, '2024-秋季', 83.5), (9, 5, '2024-秋季', 79.5),
-- 王十二的成绩
(10, 1, '2024-秋季', 96.0), (10, 4, '2024-秋季', 94.5), (10, 9, '2024-秋季', 97.0);

-- 插入教师数据
INSERT INTO teachers (name, department, title, hire_date, salary, email) VALUES
('王教授', '计算机科学', '教授', '2005-09-01', 180000.00, 'wangprof@school.edu'),
('李教授', '数学系', '教授', '2003-09-01', 175000.00, 'liprof@school.edu'),
('张老师', '外语学院', '讲师', '2015-09-01', 95000.00, 'zhangteacher@school.edu'),
('陈教授', '计算机科学', '教授', '2007-09-01', 185000.00, 'chenprof@school.edu'),
('刘教授', '数学系', '副教授', '2010-09-01', 135000.00, 'liuprof@school.edu'),
('赵教授', '计算机科学', '教授', '2006-09-01', 178000.00, 'zhaoprof@school.edu'),
('周老师', '计算机科学', '讲师', '2018-09-01', 98000.00, 'zhouteacher@school.edu'),
('吴教授', '数学系', '副教授', '2012-09-01', 130000.00, 'wuprof@school.edu');

-- 插入院系数据
INSERT INTO departments (dept_name, building, budget) VALUES
('计算机科学', '信息楼', 5000000.00),
('数学系', '理科楼A座', 3000000.00),
('外语学院', '文科楼', 2500000.00),
('物理系', '理科楼B座', 4000000.00),
('化学系', '实验楼', 3500000.00);

-- ==========================================
-- 创建视图和索引
-- ==========================================

-- 创建学生成绩视图
CREATE VIEW student_grades AS
SELECT 
    s.student_id,
    s.name AS student_name,
    c.course_name,
    e.semester,
    e.grade,
    c.credits
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- 创建索引提高查询性能
CREATE INDEX idx_student_name ON students(name);
CREATE INDEX idx_course_name ON courses(course_name);
CREATE INDEX idx_enrollment_grade ON enrollments(grade);
CREATE INDEX idx_department ON courses(department);

-- ==========================================
-- 验证数据
-- ==========================================

SELECT '学生表记录数：' AS info, COUNT(*) AS count FROM students
UNION ALL
SELECT '课程表记录数：', COUNT(*) FROM courses
UNION ALL
SELECT '选课记录数：', COUNT(*) FROM enrollments
UNION ALL
SELECT '教师表记录数：', COUNT(*) FROM teachers
UNION ALL
SELECT '院系表记录数：', COUNT(*) FROM departments;

SELECT '✅ 数据库初始化完成！' AS status;
