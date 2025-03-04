#use mydb2

CREATE TABLE customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(50),
  email VARCHAR(50)
);

CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT, 
  customer_id INT,
  total_amount INT,
  order_date DATE
);


INSERT INTO customers VALUES
  (1, 'John Doe', 'john@example.com'),
  (2, 'Jane Smith', 'jane@example.com'),
  (3, 'Bob Johnson', 'bob@example.com');

INSERT INTO orders VALUES
  (1, 1, 100, '2023-01-01'),
  (2, 1, 50, '2023-02-15'),
  (3, 2, 75, '2023-03-20'),
  (4, 2, 125, '2023-04-10');
  
  
SELECT a.id, a.name, a.email,
	b.id AS ordid, b.total_amount, b.order_date
FROM customers a
INNER JOIN orders b
ON a.id=b.customer_id
WHERE b.total_amount>=100


#################################################################
CREATE TABLE employees (
  id INT PRIMARY KEY,
  NAME VARCHAR(50),
  department_id INT
);

CREATE TABLE departments (
  id INT PRIMARY KEY,
  NAME VARCHAR(50)
);

INSERT INTO employees VALUES
  (1, 'John Doe', 1),
  (2, 'Jane Smith', 2),
  (3, 'Bob Johnson', NULL);

INSERT INTO departments VALUES
  (1, 'Sales'),
  (2, 'Marketing');
  
SELECT * FROM employees
SELECT * FROM departments


#inner join: 두 테이블에서 공통된 데이터만 조회
SELECT a.name, b.name AS dept_name FROM employees a
INNER JOIN departments b
ON a.department_id=b.id  

#left join:왼쪽 테이블의 모든 데이터와 오른쪽 테이블에서 일치하는 데이터 조회
SELECT a.name, b.name AS dept_name FROM employees a
LEFT JOIN departments b
ON a.department_id=b.id

#right join
SELECT c.name, c.email, o.id, o.total_amount, o.order_date
FROM mydb2.orders o
RIGHT JOIN mydb2.customers c ON c.id=o.customer_id

##########################################################
CREATE TABLE products (
    id INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE inventories (
    id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);

INSERT INTO products (id, NAME, category) VALUES
(1, 'Product A', 'Category 1'),
(2, 'Product B', 'Category 1'),
(3, 'Product C', 'Category 2'),
(4, 'Product D', 'Category 2');

INSERT INTO inventories (id, product_id, quantity) VALUES
(1, 1, 10),
(2, 2, 5),
(3, 3, 0),
(4, 5, 15);

SELECT * FROM products
SELECT * FROM inventories

#
SELECT p.id, p.name, p.category, i.quantity
FROM products p
LEFT JOIN inventories i ON p.id=i.product_id

UNION ALL

SELECT p.id, p.name, p.category, i.quantity
FROM products p
RIGHT JOIN inventories i ON p.id=i.product_id
 
##########################################################
CREATE TABLE customer (
    customer_id INT,
    customer_name VARCHAR(50),
    customer_email VARCHAR(50),
    customer_city VARCHAR(50)
);

CREATE TABLE `order` (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_amount INT
);


INSERT INTO customer (customer_id, customer_name, customer_email, customer_city)
VALUES
  (1, 'John Doe', 'john.doe@example.com', 'New York'),
  (2, 'Jane Smith', 'jane.smith@example.com', 'Los Angeles'),
  (3, 'Bob Johnson', 'bob.johnson@example.com', 'Chicago'),
  (4, 'Emily Davis', 'emily.davis@example.com', 'Houston');

INSERT INTO `order` (order_id, customer_id, order_date, order_amount)
VALUES
  (1, 1, '2023-04-01', 100.00),
  (2, 1, '2023-05-15', 50.00),
  (3, 2, '2023-06-01', 75.00),
  (4, 3, '2023-06-15', 150.00),
  (5, 3, '2023-07-01', 200.00),
  (6, 4, '2023-07-15', 125.00);
  
SELECT * FROM `order`
SELECT * FROM customer

#총주문금액을 계산하고 고객이름, 이메일, 총 주문금액 출력
SELECT c.customer_name, c.customer_email, SUM(o.order_amount) AS total_amount_
FROM customer c 
INNER JOIN `order` o 
ON c.customer_id=o.customer_id
GROUP BY c.customer_id

#고객 주문 건수가 많은 상위 3개 도시 출력
SELECT c.customer_city, COUNT(o.order_id) AS order_count FROM customer c
INNER JOIN `order` o
ON c.customer_id=o.customer_id
GROUP BY c.customer_city
ORDER BY order_count DESC
LIMIT 3

#각 도시별 고객 수와 총 주문 금액
SELECT c.customer_city,
	COUNT(DISTINCT c.customer_id) AS customer_cnt,
	SUM(o.order_amount) AS total_amount
FROM customer c
INNER JOIN `order` o
ON c.customer_id=o.customer_id
GROUP BY c.customer_city

SELECT LEFT(order_date,4) FROM `order`
SELECT RIGHT(order_date,2) FROM `order`

