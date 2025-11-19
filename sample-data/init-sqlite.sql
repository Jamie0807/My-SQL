-- ==========================================
-- SQLite Sample Database Initialization Script
-- For quick practice environment setup
-- ==========================================

-- SQLite doesn't need CREATE DATABASE, just create tables directly

-- ==========================================
-- Create Table Structure
-- ==========================================

-- Students table
CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    gender TEXT NOT NULL CHECK(gender IN ('Male', 'Female')),
    birth_date DATE,
    email TEXT UNIQUE,
    phone TEXT,
    enrollment_date DATE DEFAULT (DATE('now')),
    gpa REAL CHECK (gpa >= 0 AND gpa <= 4.0)
);

-- Courses table
CREATE TABLE IF NOT EXISTS courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name TEXT NOT NULL,
    credits INTEGER NOT NULL,
    teacher TEXT,
    department TEXT
);

-- Enrollments table (many-to-many relationship)
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    course_id INTEGER,
    semester TEXT,
    grade REAL,
    enrollment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- Teachers table
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    department TEXT,
    title TEXT NOT NULL CHECK(title IN ('Professor', 'Associate Professor', 'Lecturer', 'Assistant')),
    hire_date DATE,
    salary REAL,
    email TEXT
);

-- Departments table
CREATE TABLE IF NOT EXISTS departments (
    dept_id INTEGER PRIMARY KEY AUTOINCREMENT,
    dept_name TEXT NOT NULL UNIQUE,
    building TEXT,
    budget REAL
);

-- ==========================================
-- Insert Sample Data
-- ==========================================

-- Insert student data
INSERT INTO students (name, gender, birth_date, email, phone, gpa, enrollment_date) VALUES
('John Smith', 'Male', '2000-05-15', 'john.smith@example.com', '555-0101', 3.75, '2018-09-01'),
('Emma Johnson', 'Female', '2001-03-20', 'emma.j@example.com', '555-0102', 3.85, '2019-09-01'),
('Michael Brown', 'Male', '2000-08-10', 'michael.b@example.com', '555-0103', 3.50, '2018-09-01'),
('Sophia Davis', 'Female', '2001-01-05', 'sophia.d@example.com', '555-0104', 3.92, '2019-09-01'),
('William Wilson', 'Male', '2000-11-25', 'william.w@example.com', '555-0105', 3.60, '2018-09-01'),
('Olivia Martinez', 'Female', '2001-06-15', 'olivia.m@example.com', '555-0106', 3.45, '2019-09-01'),
('James Anderson', 'Male', '2000-12-01', 'james.a@example.com', '555-0107', 3.78, '2018-09-01'),
('Isabella Taylor', 'Female', '2001-04-18', 'isabella.t@example.com', '555-0108', 3.88, '2019-09-01'),
('Benjamin Thomas', 'Male', '2000-07-22', 'benjamin.t@example.com', '555-0109', 3.55, '2018-09-01'),
('Mia Jackson', 'Female', '2001-09-30', 'mia.j@example.com', '555-0110', 3.95, '2019-09-01'),
('Lucas White', 'Male', '2000-02-14', 'lucas.w@example.com', '555-0111', 3.42, '2018-09-01'),
('Charlotte Harris', 'Female', '2001-11-08', 'charlotte.h@example.com', '555-0112', 3.82, '2019-09-01'),
('Henry Martin', 'Male', '2000-10-05', 'henry.m@example.com', '555-0113', 3.68, '2018-09-01'),
('Amelia Thompson', 'Female', '2001-08-20', 'amelia.t@example.com', '555-0114', 3.91, '2019-09-01'),
('Alexander Garcia', 'Male', '2000-03-12', 'alex.g@example.com', '555-0115', 3.38, '2018-09-01');

-- Insert course data
INSERT INTO courses (course_name, credits, teacher, department) VALUES
('Database Systems', 4, 'Prof. Wang', 'Computer Science'),
('Calculus', 5, 'Prof. Li', 'Mathematics'),
('English Composition', 3, 'Dr. Zhang', 'Liberal Arts'),
('Data Structures', 4, 'Prof. Chen', 'Computer Science'),
('Linear Algebra', 4, 'Prof. Liu', 'Mathematics'),
('Operating Systems', 4, 'Prof. Zhao', 'Computer Science'),
('Computer Networks', 3, 'Dr. Zhou', 'Computer Science'),
('Discrete Mathematics', 3, 'Prof. Wu', 'Mathematics'),
('Python Programming', 3, 'Dr. Ma', 'Computer Science'),
('Probability Theory', 4, 'Prof. Lin', 'Mathematics'),
('Physics', 4, 'Prof. Xu', 'Physics'),
('Compiler Design', 4, 'Prof. Zheng', 'Computer Science'),
('Algorithm Design', 3, 'Dr. Qian', 'Computer Science'),
('Software Engineering', 3, 'Prof. Sun', 'Computer Science'),
('Artificial Intelligence', 4, 'Prof. Zhou', 'Computer Science');

-- Insert enrollment records (grades)
INSERT INTO enrollments (student_id, course_id, semester, grade) VALUES
-- John Smith's grades
(1, 1, 'Fall 2024', 88.5), (1, 2, 'Fall 2024', 92.0), (1, 4, 'Fall 2024', 85.5),
-- Emma Johnson's grades
(2, 1, 'Fall 2024', 95.5), (2, 3, 'Fall 2024', 87.0), (2, 2, 'Fall 2024', 90.5),
-- Michael Brown's grades
(3, 2, 'Fall 2024', 78.5), (3, 4, 'Fall 2024', 85.0), (3, 6, 'Fall 2024', 82.0),
-- Sophia Davis's grades
(4, 1, 'Fall 2024', 91.5), (4, 5, 'Fall 2024', 89.0), (4, 7, 'Fall 2024', 93.5),
-- William Wilson's grades
(5, 3, 'Fall 2024', 82.5), (5, 4, 'Fall 2024', 88.0), (5, 8, 'Fall 2024', 86.5),
-- Olivia Martinez's grades
(6, 2, 'Fall 2024', 76.5), (6, 5, 'Fall 2024', 80.0), (6, 3, 'Fall 2024', 84.5),
-- James Anderson's grades
(7, 1, 'Fall 2024', 89.5), (7, 6, 'Fall 2024', 87.5), (7, 9, 'Fall 2024', 91.0),
-- Isabella Taylor's grades
(8, 4, 'Fall 2024', 94.0), (8, 7, 'Fall 2024', 90.5), (8, 2, 'Fall 2024', 88.5),
-- Benjamin Thomas's grades
(9, 3, 'Fall 2024', 81.0), (9, 8, 'Fall 2024', 83.5), (9, 5, 'Fall 2024', 79.5),
-- Mia Jackson's grades
(10, 1, 'Fall 2024', 96.0), (10, 4, 'Fall 2024', 94.5), (10, 9, 'Fall 2024', 97.0);

-- Insert teacher data
INSERT INTO teachers (name, department, title, hire_date, salary, email) VALUES
('Prof. Wang', 'Computer Science', 'Professor', '2005-09-01', 180000.00, 'wang.prof@school.edu'),
('Prof. Li', 'Mathematics', 'Professor', '2003-09-01', 175000.00, 'li.prof@school.edu'),
('Dr. Zhang', 'Liberal Arts', 'Lecturer', '2015-09-01', 95000.00, 'zhang.dr@school.edu'),
('Prof. Chen', 'Computer Science', 'Professor', '2007-09-01', 185000.00, 'chen.prof@school.edu'),
('Prof. Liu', 'Mathematics', 'Associate Professor', '2010-09-01', 135000.00, 'liu.prof@school.edu'),
('Prof. Zhao', 'Computer Science', 'Professor', '2006-09-01', 178000.00, 'zhao.prof@school.edu'),
('Dr. Zhou', 'Computer Science', 'Lecturer', '2018-09-01', 98000.00, 'zhou.dr@school.edu'),
('Prof. Wu', 'Mathematics', 'Associate Professor', '2012-09-01', 130000.00, 'wu.prof@school.edu');

-- Insert department data
INSERT INTO departments (dept_name, building, budget) VALUES
('Computer Science', 'Information Building', 5000000.00),
('Mathematics', 'Science Building A', 3000000.00),
('Liberal Arts', 'Liberal Arts Building', 2500000.00),
('Physics', 'Science Building B', 4000000.00),
('Chemistry', 'Laboratory Building', 3500000.00);

-- ==========================================
-- Create Views and Indexes
-- ==========================================

-- Create student grades view
CREATE VIEW IF NOT EXISTS student_grades AS
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

-- Create indexes to improve query performance
CREATE INDEX IF NOT EXISTS idx_student_name ON students(name);
CREATE INDEX IF NOT EXISTS idx_course_name ON courses(course_name);
CREATE INDEX IF NOT EXISTS idx_enrollment_grade ON enrollments(grade);
CREATE INDEX IF NOT EXISTS idx_department ON courses(department);

-- ==========================================
-- Verify Data
-- ==========================================

SELECT '✅ SQLite Database Initialization Complete!' AS status;
SELECT 'Students records:' AS info, COUNT(*) AS count FROM students
UNION ALL
SELECT 'Courses records:', COUNT(*) FROM courses
UNION ALL
SELECT 'Enrollments records:', COUNT(*) FROM enrollments
UNION ALL
SELECT 'Teachers records:', COUNT(*) FROM teachers
UNION ALL
SELECT 'Departments records:', COUNT(*) FROM departments;
