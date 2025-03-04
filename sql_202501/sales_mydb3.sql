#use mydb3


CREATE TABLE sales (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(50),
  quantity INT,
  price DECIMAL(10,2),
  sale_date DATE
);


INSERT INTO sales (product_name, quantity, price, sale_date)
VALUES
  ('Product A', 10, 9.99, '2023-01-01'),
  ('Product B', 5, 19.99, '2023-01-02'),
  ('Product A', 8, 9.99, '2023-01-03'),
  ('Product C', 12, 14.99, '2023-01-04'),
  ('Product B', 3, 19.99, '2023-01-05'),
  ('Product A', 6, 9.99, '2023-02-01'),
  ('Product C', 9, 14.99, '2023-02-02'),
  ('Product B', 7, 19.99, '2023-02-03'),
  ('Product A', 4, 9.99, '2023-02-04'),
  ('Product C', 11, 14.99, '2023-02-05');
  
SELECT * FROM sales 
  
  
#1.총 매출액 계산:
SELECT SUM(price) AS sum_price FROM sales

#2.제품별 총 매출액 계산:
SELECT product_name,SUM(price) AS sum_price FROM sales
 GROUP BY product_name

#3.제품별 평균 판매 가격 계산:
SELECT product_name, AVG(price) AS avg_price FROM sales
 GROUP BY product_name

#4.월별 총 판매량 계산:
SELECT MONTH(sale_date),SUM(quantity) AS sum_quantity FROM sales 
GROUP BY MONTH(sale_date)

SELECT DATE_FORMAT(sale_date,'%Y-%m') AS `month`,
SUM(quantity) AS sum_quantity FROM sales
GROUP BY `month` ORDER BY `month`


#5.제품별 최대/최소 판매량 계산:
SELECT product_name,MAX(quantity) AS max_quantity,
 MIN(quantity) AS min_quantity FROM sales
 GROUP BY product_name

#6.제품별 총 판매량 계산:
SELECT product_name, SUM(quantity) AS sum_quantity FROM sales
 GROUP BY product_name
 
SELECT product_name, SUM(quantity) AS sum_quantity FROM sales
 WHERE DATE_FORMAT(sale_date,'%Y-%m')='2023-02'
 GROUP BY product_name
 

#7.가장 많이 팔린 제품 Top 2 구하기:
SELECT product_name, SUM(quantity) AS sum_quantity FROM sales 
GROUP BY product_name
ORDER BY sum_quantity DESC LIMIT 2

#8.제품별 총 수익 대비 판매량 비율 계산:
SELECT product_name,(SUM(quantity) / SUM(price * quantity)) AS ratio FROM sales
GROUP BY product_name

#9.가장 높은 평균 가격의 제품 구하기:
SELECT product_name, AVG(price) AS avg_price
FROM sales
GROUP BY product_name
ORDER BY avg_price DESC
LIMIT 1; 
