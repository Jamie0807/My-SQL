-- =============================================
-- 03-数据操作 / 04-事务操作 (TRANSACTION)
-- =============================================

-- 事务是一组 SQL 语句的集合，要么全部执行成功，要么全部回滚

-- =============================================
-- 1. 事务的基本概念
-- =============================================

-- 事务的四大特性 (ACID):
-- A - Atomicity（原子性）：事务中的所有操作要么全部完成，要么全部不完成
-- C - Consistency（一致性）：事务前后数据的完整性必须保持一致
-- I - Isolation（隔离性）：多个事务并发执行时，相互不干扰
-- D - Durability（持久性）：事务完成后，对数据的修改是永久的

-- =============================================
-- 2. 基本事务操作
-- =============================================

-- 开始事务
BEGIN TRANSACTION;

-- 执行一些操作
INSERT INTO students (name, gender, birth_date) 
VALUES ('Transaction Test', 'M', '2004-01-01');

-- 提交事务（保存所有更改）
COMMIT;

-- 或者回滚事务（撤销所有更改）
-- ROLLBACK;

-- =============================================
-- 3. 事务回滚示例
-- =============================================

-- 开始事务
BEGIN TRANSACTION;

-- 插入数据
INSERT INTO students (name, gender, birth_date) 
VALUES ('Rollback Test', 'F', '2004-02-01');

-- 查看插入的数据（在事务中可见）
SELECT * FROM students WHERE name = 'Rollback Test';

-- 回滚事务（撤销插入）
ROLLBACK;

-- 再次查询（数据已被撤销）
SELECT * FROM students WHERE name = 'Rollback Test';

-- =============================================
-- 4. 转账示例（经典事务场景）
-- =============================================

-- 创建账户表
CREATE TABLE IF NOT EXISTS accounts (
    account_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_name TEXT NOT NULL,
    balance REAL DEFAULT 0.00,
    CHECK (balance >= 0)
);

-- 插入测试账户
INSERT INTO accounts (account_name, balance) VALUES 
    ('Alice', 1000.00),
    ('Bob', 500.00);

-- 转账操作：Alice 向 Bob 转账 200 元
BEGIN TRANSACTION;

-- 扣除 Alice 的余额
UPDATE accounts SET balance = balance - 200 WHERE account_name = 'Alice';

-- 增加 Bob 的余额
UPDATE accounts SET balance = balance + 200 WHERE account_name = 'Bob';

-- 检查余额是否正确
SELECT * FROM accounts WHERE account_name IN ('Alice', 'Bob');

-- 如果一切正常，提交事务
COMMIT;

-- 如果有问题，使用 ROLLBACK 撤销

-- =============================================
-- 5. 使用保存点 (SAVEPOINT)
-- =============================================

-- SQLite 支持保存点
BEGIN TRANSACTION;

-- 插入第一条记录
INSERT INTO students (name, gender, birth_date) 
VALUES ('Student 1', 'M', '2004-03-01');

-- 创建保存点
SAVEPOINT sp1;

-- 插入第二条记录
INSERT INTO students (name, gender, birth_date) 
VALUES ('Student 2', 'F', '2004-04-01');

-- 创建第二个保存点
SAVEPOINT sp2;

-- 插入第三条记录
INSERT INTO students (name, gender, birth_date) 
VALUES ('Student 3', 'M', '2004-05-01');

-- 回滚到 sp2（撤销 Student 3 的插入）
ROLLBACK TO sp2;

-- 回滚到 sp1（撤销 Student 2 的插入）
ROLLBACK TO sp1;

-- 提交事务（只保留 Student 1）
COMMIT;

-- =============================================
-- 6. 错误处理与事务
-- =============================================

-- 模拟错误处理
BEGIN TRANSACTION;

-- 正常插入
INSERT INTO students (name, gender, birth_date) 
VALUES ('Error Test 1', 'M', '2004-06-01');

-- 尝试插入违反约束的数据（会失败）
-- INSERT INTO students (name, gender, birth_date) 
-- VALUES ('Error Test 2', 'X', '2004-06-01');  -- gender 只能是 M 或 F

-- 如果发生错误，回滚整个事务
ROLLBACK;

-- =============================================
-- 7. 批量操作优化
-- =============================================

-- 不使用事务（慢）
INSERT INTO students (name, gender, birth_date) VALUES ('Batch 1', 'M', '2004-01-01');
INSERT INTO students (name, gender, birth_date) VALUES ('Batch 2', 'F', '2004-01-02');
INSERT INTO students (name, gender, birth_date) VALUES ('Batch 3', 'M', '2004-01-03');
-- 每条语句都会单独提交

-- 使用事务（快很多）
BEGIN TRANSACTION;

INSERT INTO students (name, gender, birth_date) VALUES ('Batch 4', 'M', '2004-01-04');
INSERT INTO students (name, gender, birth_date) VALUES ('Batch 5', 'F', '2004-01-05');
INSERT INTO students (name, gender, birth_date) VALUES ('Batch 6', 'M', '2004-01-06');
-- ... 可以有成百上千条插入
COMMIT;
-- 一次性提交所有更改

-- =============================================
-- 8. 事务隔离级别（SQLite 相关）
-- =============================================

-- SQLite 默认使用 SERIALIZABLE 隔离级别
-- 可以通过 PRAGMA 查看和设置

-- 查看当前的日志模式
PRAGMA journal_mode;

-- 设置为 WAL 模式（Write-Ahead Logging）以提高并发性能
-- PRAGMA journal_mode=WAL;

-- =============================================
-- 9. 实际应用场景
-- =============================================

-- 场景 1: 学生选课（保证数据一致性）
BEGIN TRANSACTION;

-- 检查课程容量
SELECT COUNT(*) as enrolled_count FROM enrollments WHERE course_id = 1;

-- 如果未满，则添加选课记录
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES (1, 1, date('now'), NULL);

-- 更新课程已选人数
-- UPDATE courses SET enrolled_students = enrolled_students + 1 WHERE course_id = 1;

COMMIT;

-- 场景 2: 删除学生及其所有相关记录
BEGIN TRANSACTION;

-- 删除选课记录
DELETE FROM enrollments WHERE student_id = 99;

-- 删除学生记录
DELETE FROM students WHERE student_id = 99;

COMMIT;

-- 场景 3: 批量更新成绩
BEGIN TRANSACTION;

-- 给所有及格的学生加 5 分
UPDATE enrollments SET grade = grade + 5 WHERE grade >= 60;

-- 给不及格的学生加 10 分
UPDATE enrollments SET grade = grade + 10 WHERE grade < 60;

-- 确保没有超过 100 分
UPDATE enrollments SET grade = 100 WHERE grade > 100;

COMMIT;

-- =============================================
-- 10. 事务最佳实践
-- =============================================

-- ✅ 良好实践：
-- 1. 保持事务简短
-- 2. 不要在事务中进行用户交互或等待
-- 3. 按照固定的顺序访问表和行（避免死锁）
-- 4. 使用适当的隔离级别
-- 5. 及时提交或回滚事务

-- ❌ 避免：
-- 1. 长时间运行的事务
-- 2. 在事务中执行耗时的操作
-- 3. 忘记提交或回滚

-- =============================================
-- 11. 事务与锁
-- =============================================

-- SQLite 的锁机制：
-- 1. SHARED 锁：读取数据
-- 2. RESERVED 锁：准备写入数据
-- 3. PENDING 锁：等待写入
-- 4. EXCLUSIVE 锁：写入数据

-- 开始独占事务
BEGIN EXCLUSIVE TRANSACTION;

-- 执行一些操作
UPDATE accounts SET balance = balance * 1.05;  -- 所有账户余额增加 5%

COMMIT;

-- =============================================
-- 12. 嵌套事务模拟
-- =============================================

-- SQLite 不支持真正的嵌套事务，但可以用保存点模拟
BEGIN TRANSACTION;

    INSERT INTO students (name, gender, birth_date) VALUES ('Outer 1', 'M', '2004-01-01');
    
    SAVEPOINT nested1;
    
        INSERT INTO students (name, gender, birth_date) VALUES ('Inner 1', 'F', '2004-02-01');
        
        SAVEPOINT nested2;
        
            INSERT INTO students (name, gender, birth_date) VALUES ('Inner 2', 'M', '2004-03-01');
            
        -- 回滚 nested2
        ROLLBACK TO nested2;
        
    -- 提交 nested1
    RELEASE nested1;

COMMIT;

-- =============================================
-- 练习题
-- =============================================

-- 练习 1: 创建一个转账事务
-- 从账户 'Alice' 向 'Bob' 转账 100 元
-- 如果 Alice 余额不足，回滚事务

-- 练习 2: 使用事务批量插入 10 个学生记录
-- 要求：如果其中任何一个插入失败，全部回滚

-- 练习 3: 使用保存点
-- 插入 3 个课程，但只保留前 2 个（回滚第 3 个）

-- 练习 4: 实现一个学生退课功能
-- 删除选课记录，并更新相关的统计信息
-- 使用事务确保原子性

-- 练习 5: 模拟并发场景
-- 两个事务同时尝试更新同一条记录
-- 观察 SQLite 的锁行为

-- =============================================
-- 查看结果
-- =============================================

SELECT * FROM accounts ORDER BY account_id;
SELECT * FROM students WHERE name LIKE '%Test%' OR name LIKE '%Batch%' ORDER BY student_id DESC LIMIT 10;
