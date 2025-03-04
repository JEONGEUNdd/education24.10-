CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(50),
    age INT
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO users (NAME, age) VALUES ('John', 25), ('Jane', 30), ('Alice', 22), ('Bob', 28);
INSERT INTO orders (user_id, order_date, amount) VALUES (1, '2023-10-01', 100.00), (2, '2023-10-02', 200.00), (1, '2023-10-03', 150.00), (3, '2023-10-04', 300.00);

SELECT * FROM users;
SELECT*FROM orders
#user테이블에서 나이가 20세가 넘은 사람들의 이름과 나이 내림차순 정렬 상위10명만
SELECT `name`,age FROM users WHERE age>20 ORDER BY age DESC LIMIT 10

INSERT INTO users (`name`,age) VALUES ('chalis',21), ('toll',27)

UPDATE users SET age=age+1 WHERE 1=1 AND `name`='John'

#30세 이상인 사람 지우기
DELETE FROM users WHERE age>=30

#users테이블에서 모든 내용 지우기
TRUNCATE TABLE users

#users 테이블에서 20세 이상 30세 이하 사용자만 출력
SELECT * FROM users WHERE age>=20 AND age<=30

#J로 시작하는 사용자 정보 출력
SELECT * FROM users WHERE `name` LIKE 'J%'

#나이별 숫자 출력
SELECT age, COUNT(*) AS cnt FROM users GROUP BY age

#나이별 사람수가 2명 이상인 경우 출력
SELECT age, COUNT(*) AS cnt FROM users GROUP BY age HAVING cnt>1

#주문자정보와 사용자정보 같이 보여주기
SELECT users.name, users.age, orders.order_date, orders.amount FROM users 
INNER JOIN orders ON users.user_id=orders.user_id

SELECT a.name, a.age, b.order_date, b.amount FROM users a
INNER JOIN orders b ON a.user_id=b.user_id

#모든 사용자 정보 보여주고 주문정보 있다면 주문정보도 보여주기
SELECT a.name,a.age, b.order_date, b.amount FROM users a
LEFT JOIN orders b ON a.user_id=b.user_id

#Cross join(모든 행 조합)
SELECT A.name, B.name
FROM users A
CROSS JOIN users B;

-- participants 테이블 생성
CREATE TABLE participants (
    id INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL
);

-- products 테이블 생성
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

-- receipts 테이블 생성
CREATE TABLE receipts (
    participant_id INT,
    product_id INT,
    received VARCHAR(3), -- 'Yes' 또는 'No'를 저장
    FOREIGN KEY (participant_id) REFERENCES participants(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- participants 데이터 입력
INSERT INTO participants (id, NAME) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- products 데이터 입력
INSERT INTO products (id, product_name) VALUES
(1, 'T-shirt'),
(2, 'Mug'),
(3, 'Notebook');

-- receipts 데이터 입력
INSERT INTO receipts (participant_id, product_id, received) VALUES
(1, 1, 'Yes'),
(2, 2, 'No'),
(1, 3, 'Yes');

#참가자와 상품 조합
SELECT p.name, pr.product_name, COALESCE(r.received,'No') AS received
FROM participants p
CROSS JOIN products pr
LEFT JOIN receipts r ON p.id=r.participant_id AND pr.id=r.product_id



#########
CREATE TABLE employees1 (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(50),
    manager_id INT
);

INSERT INTO employees1 (NAME, manager_id) VALUES
('Alice', NULL),  -- Alice는 매니저가 없음 (최상위)
('Bob', 1),       -- Bob의 매니저는 Alice
('Charlie', 1),   -- Charlie의 매니저는 Alice
('David', 2),     -- David의 매니저는 Bob
('Eve', 2);       -- Eve의 매니저는 Bob

#self join
SELECT e1.name AS employee_name, e1.name AS manager_name
FROM employees1 e1
LEFT JOIN employees1 e2 ON e1.manager_id=e2.employee_id

SELECT e1.nmae AS team_member
FROM employees1 e1
JOIN employees1 e2 e1.manager_id=e2.employee_id
WHERE e2.name='Bob';

####모든 직원과 직원의 매니저, 매니저의 매니저
SELECT 
	e1.name AS employee,
	e2.name AS manager,
	e3.name AS manager_of_manager
FROM employees1 e1
LEFT JOIN 
	employees1 e2 ON e1.manager_id=e2.employee_id
LEFT JOIN
	employees1 e3 ON e2.manager_id=e3.employee_id;
