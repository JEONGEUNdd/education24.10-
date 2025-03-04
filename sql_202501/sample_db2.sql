CREATE TABLE employees ( 
    id INT PRIMARY KEY AUTO_INCREMENT, 
    NAME VARCHAR(100), 
    salary DECIMAL(10, 2), 
    department_id INT,
    manager_id INT
);

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100)
);

-- 샘플 데이터

-- 샘플 데이터 입력 (매니저 ID 포함)
INSERT INTO employees (NAME, salary, department_id, manager_id) VALUES 
('Alice', 60000, 1, NULL),
('Bob', 70000, 1, 1),     
('Charlie', 70000, 1, 1), 
('David', 90000, 2, 2),   
('Eve', 55000, 3, 2),     
('Frank', 75000, 5, 3),   
('Grace', 60000, 4, 3),   
('Hannah', 50000, 5, 4),  
('Isaac', 65000, 4, 4),   
('John', 50000, 3, 5),    
('Kathy', 72000, 3, 5),   
('Liam', 58000, 1, 1),    
('Mia', 59000, 1, 1),     
('Noah', 88000, 5, 2),    
('Olivia', 63000, 5, 3),  
('Paul', 95000, 1, 1),    
('Quinn', 42000, 3, 5),   
('Rachel', 48000, 4, 6),  
('Sam', 52000, 2, 6),     
('Tina', 54000, 2, 7);    


INSERT INTO departments (NAME) VALUES 
('HR'),
('IT'),
('Sales'),
('Marketing'),
('Finance');

#1. DML 개념
#문제: SELECT 문을 사용하여 모든 컬럼을 선택하는 쿼리를 작성하시오.
SELECT * FROM employees

#문제: 특정 직원의 이름과 급여를 선택하는 쿼리를 작성하시오.
SELECT `name`, salary FROM employees WHERE `name`='Alice'

#문제: employees 테이블에 새로운 직원을 추가하는 INSERT 쿼리를 작성하시오.
INSERT INTO employees (`name`,salary) VALUES ('sunsin',70000),('gildong',80000)

#문제: 특정 직원의 급여를 10% 인상하는 UPDATE 쿼리를 작성하시오.
UPDATE employees SET salary=salary*1.1 WHERE `name`='Alice'

#문제: employees 테이블에서 특정 직원을 삭제하는 DELETE 쿼리를 작성하시오.
DELETE FROM employees WHERE id=22

#문제: TRUNCATE와 DELETE의 차이점은 무엇인가요?
#truncate:모든 행 삭제 및 초기화
#delete:조건에 맞는 행만 삭제

#문제: INSERT 문의 ON DUPLICATE KEY UPDATE를 활용한 쿼리를 작성하시오.
INSERT INTO employees (`name`,salary) VALUES ('Alice',70000) 
ON DUPLICATE KEY UPDATE salary=70000;

#문제: 여러 행을 한 번에 INSERT 하는 쿼리를 작성하시오.
INSERT INTO employees (`name`, salary) VALUES ('sunsin', 70000),('gildong', 80000)

#문제: UPDATE 쿼리에서 WHERE 절을 빠뜨리면 어떻게 되는가?
#모든 행이 업데이트 됩니다.

#문제: DELETE 쿼리에서 WHERE 절을 빠뜨리면 어떻게 되는가?
#모든 행이 삭제 됩니다.

#2. 조건절과 그룹함수 활용
#문제: WHERE 절을 사용하여 급여가 60000 이상인 직원을 선택하는 쿼리를 작성하시오.
SELECT * FROM employees WHERE salary>=60000

#문제: GROUP BY 절을 사용하여 각 급여대의 직원 수를 세는 쿼리를 작성하시오.
SELECT salary, COUNT(*) AS cnt FROM employees GROUP BY salary

#10000 범위를 기준으로 그룹핑
SELECT 
    FLOOR(salary / 10000) * 10000 AS salary_range,
    COUNT(*) AS cnt 
FROM employees GROUP BY salary_range;

#문제: HAVING 절을 사용하여 직원 수가 2명 이상인 급여대만 선택하는 쿼리를 작성하시오.
SELECT salary, COUNT(*) AS cnt FROM employees GROUP BY salary HAVING cnt >= 2

#문제: WHERE 절과 HAVING 절의 차이점은 무엇인가요?
#WHERE: 그룹화 이전에 행을 필터링
#HAVING: 그룹화 이후에 그룹을 필터링

#문제: ORDER BY 절을 사용하여 급여를 기준으로 오름차순 정렬하는 쿼리를 작성하시오.
SELECT * FROM employees ORDER BY salary ASC

#문제: WHERE 절에서 AND와 OR 연산자를 사용하는 예를 들어보시오.
SELECT * FROM employees WHERE salary > 60000 AND NAME LIKE 'A%'

#문제: GROUP BY 절에서 여러 컬럼을 그룹화하는 쿼리를 작성하시오.
SELECT `name`, salary, manager_id, COUNT(*) FROM employees GROUP BY manager_id, salary

#문제: COUNT, AVG, SUM과 같은 그룹 함수를 사용하는 예를 들어보시오.
SELECT COUNT(*), AVG(salary), SUM(salary) FROM employees

#문제: ORDER BY 절을 사용하여 급여를 기준으로 내림차순 정렬하는 쿼리를 작성하시오.
SELECT * FROM employees ORDER BY salary DESC


#문제: GROUP BY 절을 사용할 때 주의해야 할 사항은 무엇인가요?
#GROUP BY에 포함된 컬럼을 셀렉트에 사용하고 나머지는 집계함수와 같이 사용

#3. JOIN의 개념과 종류
#문제: INNER JOIN을 사용하여 두 테이블을 결합하는 쿼리를 작성하시오.
SELECT employees.name, employees.salary, departments.name AS dept
FROM employees
INNER JOIN departments
ON employees.department_id=departments.id

#문제: LEFT JOIN을 사용하여 직원과 부서를 결합하는 쿼리를 작성하시오.
SELECT em.name, em.salary, dp.name AS dept
FROM employees em
LEFT JOIN departments dp
ON em.department_id=dp.id
WHERE dp.name IS NULL

#문제: RIGHT JOIN을 사용하여 부서와 직원을 결합하는 쿼리를 작성하시오.
SELECT * FROM employees
RIGHT JOIN departments
ON employees.department_id = departments.id

#문제: CROSS JOIN을 사용하여 모든 직원과 부서의 조합을 생성하는 쿼리를 작성하시오.
SELECT employees.`name`, departments.`name` AS dept
FROM employees 
CROSS JOIN departments;

#문제: SELF JOIN의 개념을 설명하고 예를 들어보시오.
#동일한 테이블을 두 번 사용하여 데이터를 결합
SELECT a.name, b.name AS manager 
FROM employees a, employees b 
WHERE a.manager_id = b.id

#문제: INNER JOIN과 OUTER JOIN의 차이점은 무엇인가요?
INNER JOIN은 두 테이블에서 일치하는 행만 반환하고, 
OUTER JOIN은 한쪽 테이블의 모든 행과 일치하는 행을 반환

#문제: JOIN을 사용할 때 성능 최적화를 위해 주의해야 할 사항은 무엇인가요?
인덱스 사용, 필요하지 않은 데이터(컬럼)는 선택하지 않는다

#문제: LEFT JOIN을 사용해 NULL 값을 포함한 결과를 얻는 쿼리를 작성하시오.
SELECT * FROM employees 
LEFT JOIN departments
ON employees.department_id = departments.id

#문제: 간단한 INNER JOIN 쿼리를 작성하시오.
SELECT e.name, d.name FROM employees e
INNER JOIN departments d
ON e.department_id = d.id

#문제: JOIN을 사용할 때 어떤 상황에서 CROSS JOIN을 사용할 수 있나요?
모든 조합이 필요한 경우(모든 직원과 모든 팀의 조합)
#문제: JOIN을 사용할 때 어떤 상황에서 CROSS JOIN을 사용할 수 있나요?

#######################################
################################
#사용자 정의 무결성(18세 이상 확인)
CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
	birthdate DATE,
	CHECK (DATEDIFF(CURDATE(),birthdate)/365.25>=18)  #18세이상확인

CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
	age INT CHECK (age>=18)  #18세 이상 확인
);
