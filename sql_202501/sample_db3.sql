-- 직원 테이블 생성
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- 고객 테이블 생성
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    join_date DATE
);

-- 주문 테이블 생성
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME,
    amount DECIMAL(10,2),
    STATUS VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 직원 데이터 삽입
INSERT INTO employees (first_name, last_name, email, phone, department, salary, hire_date) VALUES
('김', '민수', 'kim.ms@example.com', '010-1234-5678', 'IT', 65000.00, '2023-01-15'),
('이', '영희', 'lee.yh@example.com', '010-2345-6789', 'HR', 55000.00, '2023-02-20'),
('박', '준서', 'park.js@example.com', '010-3456-7890', 'Marketing', 60000.00, '2023-03-10'),
('최', '수진', 'choi.sj@example.com', '010-4567-8901', 'IT', 70000.00, '2023-04-05'),
('정', '대현', 'jung.dh@example.com', '010-5678-9012', 'Finance', 75000.00, '2023-05-12'),
('강', '미나', 'kang.mn@example.com', '010-6789-0123', 'HR', 52000.00, '2023-06-18'),
('조', '현우', 'cho.hw@example.com', '010-7890-1234', 'Marketing', NULL, '2023-07-22'),
('윤', '서연', 'yoon.sy@example.com', '010-8901-2345', 'IT', 68000.00, '2023-08-30');

-- 고객 데이터 삽입
INSERT INTO customers (full_name, email, phone, address, join_date) VALUES
('홍길동', 'hong.gd@example.com', '010-1111-2222', '서울시 강남구', '2023-01-01'),
('김철수', 'kim.cs@example.com', '010-2222-3333', '서울시 서초구', '2023-02-15'),
('이영희', 'lee.yh@example.com', '010-3333-4444', '경기도 성남시', '2023-03-20'),
('박민준', 'park.mj@example.com', '010-4444-5555', '인천시 연수구', '2023-04-10'),
('정소율', 'jung.sy@example.com', '010-5555-6666', '부산시 해운대구', '2023-05-05');

-- 주문 데이터 삽입
INSERT INTO orders (customer_id, order_date, amount, STATUS) VALUES
(1, '2024-01-10 10:30:00', 150000.00, 'completed'),
(2, '2024-01-15 14:20:00', 89000.00, 'completed'),
(3, '2024-02-01 09:15:00', 230000.00, 'processing'),
(1, '2024-02-10 16:40:00', 45000.00, 'completed'),
(4, '2024-02-15 11:30:00', 128000.00, 'completed'),
(2, '2024-03-01 13:20:00', 76000.00, 'processing'),
(5, '2024-03-10 15:45:00', 195000.00, 'completed'),
(3, '2024-03-15 17:10:00', 88000.00, 'processing'),
(4, '2024-04-01 10:20:00', 167000.00, 'completed'),
(5, '2024-04-10 12:30:00', 143000.00, 'processing');

SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM orders;

# CONCAT (문자열 연결함수)
SELECT CONCAT('Hello','World')
SELECT CONCAT('Hello','','World')
SELECT first_name, last_name FROM employees

SELECT *, CONCAT(first_name,last_name) AS full_name FROM employees
SELECT CONCAT(full_name,'(',email,')') AS c_info FROM customers
SELECT CONCAT('OrderID :', order_id, ', Amount: ', amount) AS order_info FROM orders;

# CONCAT_WS (여러 문자열을 seporator로 연결)
SELECT CONCAT('-','Kim', 'Min', 'Su');
SELECT CONCAT_WS('-', 'Kim', 'Min', 'Su');
# 중간에 '-'을 넣어주면서 seporator로 연결 

--- 직원의 전체 이름과 부서 결합
SELECT first_name, last_name, department FROM employees
SELECT CONCAT(first_name, last_name, department) FROM employees
SELECT CONCAT_WS(', ', first_name, last_name, department) FROM employees


-- 고객의 연락처 정보 결합
SELECT CONCAT_WS(' | ', full_name, phone, email) AS user_info FROM customers

SELECT CONCAT_WS(', ', CONCAT('OrderID: ', order_id), CONCAT('Amount: ', amount)) AS orders;

#SUBSTRING(문자열, 시작위치, 길이)
SELECT SUBSTRING('MySQL Tutorial', 1, 5);
SELECT SUBSTRING('MySQL Tutorial', 7);
SELECT SUBSTRING('MySQL Tutorial', -8);

# 회원정보 *로 표시 
SELECT CONCAT(SUBSTRING(full_name,1,1),'***') FROM customers

SELECT SUBSTRING ( 'MySQL Tutorial', 7) ;
SELECT SUBSTRING ('MySQL Tutorial', -8);

SELECT CONCAT(SUBSTRING(full_name, 1,1), '**') FROM customers

SELECT SUBSTRING(email, LOCATE('@', email) + 1) AS email_domain FROM customers;
SELECT SUBSTRING(email, 1, LOCATE('@', email) - 1) AS email_domain FROM customers;

# 주문일자에서 연도만 출력하기
SELECT SUBSTRING(order_date, 1, 4) AS order_year FROM orders;

#TRIM
SELECT CONCAT('###','MySQL','###');
SELECT CONCAT('###','        MySQl  ','###');
SELECT CONCAT('###',TRIM('       MySQL     ','###');
SELECT CONCAT('###',RTRIM('       MySQL     ','###');

SELECT TRIM(address) AS addr FROM customers


#REPLACE
SELECT *, REPLACE(email,'example.com','gmail.com') AS email2 FROM employees;
SELECT *, REPLACE(phone,'-','') AS cleaned_phone FROM customers

SELECT REPLACE(`status`, 'completed','processing') AS updated_status FROM orders;

#숫자함수
#round/ceil/floor
SELECT ROUND(salary,2) AS rounded_salary FROM employees;
SELECT ROUND(123.4567,0) AS rounded_number;  #소수점제외

SELECT CEIL(123.01) AS ceil_number;
SELECT FLOOR(123.9) AS floor_number;

#ABS(절댓값)
SELECT ABS(-123.45) AS absolute_value;

#POW(거듭제곱)
SELECT POW(5,3) power_value; #5의 3제곱

#MOD(나머지)
SELECT salary, MOD(salary, 112000) AS salary_mod FROM employees;

#날짜함수
#DATE_FORMAT
SELECT NOW();
SELECT DATE_FORMAT(NOW(),'%Y-%m-%d');

#DATEDIFF(두 날짜사이의 일 수)
SELECT DATEDIFF('2025-02-02','2025-01-01')
SELECT DATEDIFF(NOW(),'2025-12-31') AS days_since_new_year;

#now/sysdate(현재날짜와 시간 반환)
#now:쿼리호출기준
#sysdate:함수호출기준
SELECT NOW(),SYSDATE()
SELECT NOW(),NOW()
SELECT NOW(),SLEEP(2),SYSDATE();

SELECT 
	last_name,
	hire_date,
	DATE_FORMAT(hire_date,  '%Y년 %m월 %d일') AS formatted_date,
	DATEDIFF(NOW(),hire_date) AS worked_days
FROM employees;

##
SELECT COUNT(*) FROM employees;  -- null포함 카운트
SELECT COUNT(salary) FROM employees;  -- null비포함 카운트
SELECT COUNT(phone) FROM employees;

#DISTINCT(중복제외)
SELECT COUNT(DISTINCT department) FROM employees;  #중복제외

SELECT 
	department,
	COUNT(*) AS emp_count,
	MAX(salary) AS max_salary,
	MIN(salary) AS min_salary,
	AVG(salary) AS avg_salary
FROM employees
GROUP BY department;








