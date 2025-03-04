#데이터베이스 생성
CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

#테이블 생성
CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL
);

#샘플 데이터 삽입
INSERT INTO employees (NAME, email, department, salary, hire_date) VALUES
    ('김철수', 'kim@example.com', '개발팀', 45000000, '2023-01-15'),
    ('이영희', 'lee@example.com', '인사팀', 38000000, '2023-02-20'),
    ('박민수', 'park@example.com', '마케팅팀', 42000000, '2023-03-10'),
    ('정지원', 'jung@example.com', '개발팀', 48000000, '2023-04-05'),
    ('한미영', 'han@example.com', '영업팀', 39000000, '2023-05-12'),
    ('송태호', 'song@example.com', '개발팀', 51000000, '2023-06-18'),
    ('임수진', 'lim@example.com', '인사팀', 36000000, '2023-07-22'),
    ('강동훈', 'kang@example.com', '마케팅팀', 41000000, '2023-08-30'),
    ('조민재', 'cho@example.com', '영업팀', 43000000, '2023-09-14'),
    ('윤서연', 'yoon@example.com', '개발팀', 47000000, '2023-10-25');

#데이터 확인
SELECT * FROM employees;

#부서별 평균 급여 확인
SELECT 
    department,
    COUNT(*) AS 직원수,
    FORMAT(AVG(salary), 0) AS 평균급여,
    FORMAT(MIN(salary), 0) AS 최소급여,
    FORMAT(MAX(salary), 0) AS 최대급여
FROM employees
GROUP BY department;