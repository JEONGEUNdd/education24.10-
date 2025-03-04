CREATE TABLE sales (
	id INT PRIMARY KEY AUTO_INCREMENT,
	product VARCHAR(50),
	price INT,
	quantity INT,
	customer VARCHAR(50),
	sale_date DATE
);

INSERT INTO sales() VALUES
(1,'product A',10,5,'Customer A','2025-01-01')

INSERT INTO sales VALUES
  (2, 'Product B', 15, 3, 'Customer B', '2025-01-02'),
  (3, 'Product A', 10, 7, 'Customer A', '2025-01-03'),
  (4, 'Product C', 20, 2, 'Customer C', '2025-01-04'),
  (5, 'Product B', 15, 4, 'Customer B', '2025-01-05'),
  (6, 'Product A', 10, 6, 'Customer A', '2025-01-06'),
  (7, 'Product C', 20, 3, 'Customer C', '2025-01-07'),
  (8, 'Product B', 15, 2, 'Customer D', '2025-01-08'),
  (9, 'Product A', 10, 8, 'Customer A', '2025-01-09'),
  (10, 'Product C', 20, 1, 'Customer E', '2025-01-10');
 
CREATE TABLE IF NOT EXISTS sales2 (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`product` VARCHAR(50) DEFAULT NULL,
	`price` INT DEFAULT NULL,
	`quantity` INT DEFAULT NULL,
	`customer` VARCHAR(50) DEFAULT NULL,
	`sale_date` DATE DEFAULT NULL,
	PRIMARY KEY(`id`)
);
#테이블 데이터 복사  
SELECT * FROM sales2 SELECT * FROM sales

#테이블 생성하면서 데이터 복사(primary key,auto_increment는 제외)
CREATE TABLE IF NOT EXISTS `sales3` SELECT * FROM sales

#테이블 구조 복사
CREATE TABLE IF NOT EXISTS `sales4` LIKE sales

SHOW CREATE TABLE sales

#2. sales 테이블에서 quantity 값이 5보다 큰 경우 'Large', 그렇지 않은 경우 'Regular'를 order_type 열에 표시하는 쿼리를 작성하세요. (IF사용)
SELECT *, IF(quantity>5, 'Large','Regular') AS order_type FROM sales

#3. sales 테이블에서 quantity 값에 따라 5보다 크면  'Large', 2보다 크면  'Regular', 나머지는  'Small'로 구분하여 order_type 열에 표시하는 쿼리를 작성하세요. (CASE WHEN 사용)
SELECT id, product, price, quantity,
CASE
	WHEN quantity>5 THEN 'Large'
	WHEN quantity>2 THEN 'Regular'
	ELSE 'Small'
END AS order_type FROM sales

#4. sales 테이블에서 customer 열이 'Customer A'인 행만 선택하는 쿼리를 작성하세요.
SELECT * FROM sales WHERE customer='Customer A'

#5. sales 테이블을 sale_date 열을 기준으로 내림차순 정렬하는 쿼리를 작성하세요.
SELECT * FROM sales ORDER BY sale_date DESC

#1월3일~1월7일 데이터중에서 sale_date열 기준으로 내림차순
SELECT * FROM sales WHERE sale_date>='2025-01-03' AND sale_date<='2025-01-07' ORDER BY sale_date DESC
SELECT * FROM sales WHERE sale_date BETWEEN '2025-01-03' AND '2025-01-07' ORDER BY sale_date DESC

#6. sales 테이블에서 product 열을 기준으로 그룹화하고, 각 그룹의 total_quantity를 계산하는 쿼리를 작성하세요.
SELECT product, SUM(quantity) AS total_quantity FROM sales GROUP BY product

#7. sales 테이블에서 처음 3행만 선택하는 쿼리를 작성하세요.
SELECT * FROM sales LIMIT 3
SELECT * FROM sales LIMIT 0,3

#8. sales 테이블의 price 열의 평균값을 계산하는 쿼리를 작성하세요.
SELECT AVG(price) AS avg_price FROM sales

#9. sales 테이블의 quantity 열의 합계를 계산하는 쿼리를 작성하세요.
SELECT SUM(quantity) AS sun_quantity FROM sales
SELECT product, SUM(quantity) AS sun_quantity FROM sales GROUP BY product #상품별

#10. sales 테이블의 최대 가격, 최소 가격, 총 판매 수량, 총 판매건수를 계산하는 쿼리를 작성하세요.
SELECT MAX(price) AS max_price, 
	MIN(price) AS min_price,
	SUM(quantity) AS sum_quantity,
	COUNT(*)AS total_count
FROM sales

###############################################################
CREATE TABLE job (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(50),
	department VARCHAR(50),
	salary INT
);

INSERT INTO job VALUES
  (1, '육동이', 'Sales', 50000),
  (2, '사동이', 'Marketing',45000),
  (3, '칠동이', 'Sales', 55000),
  (4, '삼동이', 'IT', 60000),
  (5, '구동이', 'Sales', 52000),
  (6, '삼동이', 'Marketing', 47000),
  (7, '이동이', 'IT', 58000),
  (8, '오동이', 'Sales', 51000),
  (9, '일동이', 'Marketing', 46000),
  (10, '팔동이', 'IT', 62000)
;
 
SELECT * FROM job

#팀명(중복제거)
SELECT DISTINCT department FROM job
SELECT department FROM job GROUP BY department

#전체 연봉 평균
SELECT AVG(salary) FROM job

#팀별 연봉 평균(5000이상)
SELECT department, AVG(salary) AS avg_salary FROM job 
GROUP BY department HAVING avg_salary>50000 ORDER BY avg_salary DESC

#부서별 직원수
SELECT department,COUNT(*) AS dept_cnt FROM job GROUP BY department

#부서별 직원수가 4명 미만인 부서
SELECT department,COUNT(*) AS dept_cnt
FROM job GROUP BY department HAVING dept_cnt<4


#각 부서에서 가장 높은 급여를 받는 직원의 이름, 부서, 급여
SELECT `name`, department, MAX(salary) AS max_salary 
FROM job GROUP BY department

#서브쿼리 방식
SELECT `name`, salary, department FROM job WHERE (department, salary)
IN (SELECT department, MAX(salary) FROM job GROUP BY department)

#join방식
SELECT e.name, e.department, e.salary
FROM job e
INNER JOIN (
	SELECT department, MAX(salary) AS max_salary
	FROM job
	GROUP BY department
) t
ON e.department=t.department AND e.salary=t.max_salary


