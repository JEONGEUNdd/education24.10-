INSERT INTO sales (id, department, sales_amount) VALUES
(1, 'Electronics', 200),
(2, 'Clothing', 150),
(3, 'Electronics', 300),
(4, 'Home', 100),
(5, 'Clothing', 250),
(6, 'Home', 50),
(7, 'Electronics', 400),
(8, 'Clothing', 200),
(9, 'Home', 150);

WITH sales_summary AS(
	SELECT department,SUM(sales_amount) AS total_sales
	FROM sales
	GROUP BY department
)
SELECT * FROM sales_summary;
	
CREATE TABLE sales2 (
    id INT PRIMARY KEY,
    department VARCHAR(50),
    amount DECIMAL(10, 2),
    sale_date DATE
);

INSERT INTO sales2 (id, department, amount, sale_date) VALUES
(1, 'Electronics', 200.00, '2023-01-15'),
(2, 'Clothing', 150.00, '2023-01-20'),
(3, 'Electronics', 300.00, '2023-02-10'),
(4, 'Home', 100.00, '2023-01-25'),
(5, 'Clothing', 250.00, '2023-02-15'),
(6, 'Home', 50.00, '2023-02-20'),
(7, 'Electronics', 400.00, '2023-03-05'),
(8, 'Clothing', 200.00, '2023-03-15'),
(9, 'Home', 150.00, '2023-03-20'),
(10, 'Electronics', 600.00, '2023-03-25'),
(11, 'Clothing', 300.00, '2023-03-28'),
(12, 'Home', 200.00, '2023-04-01');

WITH sales_analysis AS(
	SELECT department, COUNT(*) AS total_sales,
	AVG(amount) AS avg_sale, MAX(amount) AS max_sale,
	MIN(amount) AS min_sale, DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
	DENSE_RANK() OVER (PARTITION BY department ORDER BY amount DESC) AS sale_rank
	FROM sales2
	WHERE YEAR(sale_date)=2023
	GROUP BY department,DATE_FORMAT(sale_date,'%Y-%m')
)
SELECT * FROM sales_analysis;

##############################
WITH monthly_sales AS (
    SELECT 
        department,
        SUM(amount) AS total_amount,
        DATE_FORMAT(sale_date, '%Y-%m') AS sale_month
    FROM sales2
    GROUP BY department, DATE_FORMAT(sale_date, '%Y-%m')
),
department_stats AS (
    SELECT 
        department,
        AVG(total_amount) AS avg_monthly_sales,
        MAX(total_amount) AS max_monthly_sales,
        MIN(total_amount) AS min_monthly_sales,
        COUNT(DISTINCT sale_month) AS months_count
    FROM monthly_sales
    GROUP BY department
),
final_analysis AS (
    SELECT 
        d.*,
        RANK() OVER (ORDER BY avg_monthly_sales DESC) AS dept_rank,
        ROUND((max_monthly_sales - min_monthly_sales) / avg_monthly_sales * 100, 2) AS fluctuation_rate
    FROM department_stats d
)
SELECT * FROM final_analysis;


###view table
CREATE VIEW sales_summary AS
SELECT department,SUM(sales_amount) AS total_sales
FROM sales
GROUP BY department;

SELECT*FROM sales_summary;

#####
-- 테이블 생성
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE price_history (
    product_id INT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date DATETIME
);

-- 상품 데이터 삽입
INSERT INTO products VALUES
(1, '노트북', 1200000),
(2, '스마트폰', 800000),
(3, '태블릿', 500000);

#############트리거
DELIMITER //
CREATE TRIGGER log_price_changes
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	INSERT INTO price_history(product_id,old_price,new_price,change_date)
	VALUES (NEW.product_id,OLD.price, NEW.price, NOW());
END;
//
DELIMITER;


