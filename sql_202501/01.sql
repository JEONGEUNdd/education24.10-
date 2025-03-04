CREATE DATABASE mydb
CREATE DATABASE mydb2

CREATE TABLE mytable(
	id INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(255) NOT NULL,
	age INT
)
mydb
-사용자 생성
CREATE USER 'sejong'@'localhost' IDENTIFIED BY '1234';
ALTER USER 'root'@'localhost' IDENTIFIED BY '2345';
GRANT ALL PRIVILEGES ON mydb.mytable TO 'sejong'@'localhost';

-사용자 권한 확인
SHOW GRANTS FOR 'sejong'@'localhost';

-권한적용
FLUSH PRIVILEGES;

CREATE TABLE mytable (
    idx INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    userid VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    username VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    age TINYINT(3) UNSIGNED NULL DEFAULT '0',
    email VARCHAR(100) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (idx) USING BTREE
)


INSERT INTO mytable (userid, username, age, email) 
VALUES ('lee','이순신',45,'lee@a.com')

INSERT INTO mytable (userid, username, age, email) 
VALUES ('park','박찬호',45,'park@a.com')

INSERT INTO mytable (userid, username, age, email) 
VALUES ('hong','홍길동',35,'hong@a.com')


INSERT INTO mytable (userid, username, age, email) 
VALUES
('kim','김유신',40,'kim@a.com'),
('kim','김유신1',42,'kim@a.com'),
('kim','김유신2',44,'kim@a.com')


SELECT * FROM mytable WHERE username='이순신'
SELECT * FROM mytable WHERE username LIKE '김유신%'

SELECT * FROM mytable WHERE username NOT LIKE '%김유신'
SELECT * FROM mytable WHERE username <>'김유신' 
SELECT * FROM mytable WHERE username ='김유신' OR username='이순신'

SELECT * FROM mytable WHERE age BETWEEN 35 AND 50

SELECT * FROM mytable WHERE age>=40

SELECT * FROM mytable WHERE username LIKE '김%' AND age>=40
SELECT userid, username, age FROM mytable WHERE username LIKE '홍%' OR age>=45

#홍씨 또는 이씨 이면서 45세 이하
SELECT userid, username, age FROM mytable WHERE (username LIKE '홍%' OR username LIKE '이%') AND age<=45

#이메일이 null값
SELECT * FROM mytable WHERE email IS NULL OR TRIM(email)=''

SELECT * FROM mytable WHERE userid IS NULL
	OR username IS NULL
	OR email IS NULL

#정렬
SELECT * FROM mytable WHERE age>=40 ORDER BY age ASC, username DESC

SELECT * FROM mytable

SELECT * FROM mytable WHERE age<=45
	AND username IN ('홍길동','이순신')
	OR email IS NULL
	ORDER BY age
	
#데이터수정
UPDATE `mytable`
SET username='박찬호'
WHERE username='박찬호2'

UPDATE `mytable` SET age=30 WHERE username IN ('홍길동','이순신')
UPDATE `mytable` SET email='hong@a.com' WHERE username='홍길동' AND email IS NULL

#이순신의 나이를 35세로 이메일을 leess@a.com으로 수정
UPDATE `mytable` SET age=35, email='leess@a.com' WHERE username='이순신'

UPDATE `mytable` SET email='oldage@a.com' WHERE age>=45

UPDATE `mytable` SET username=CONCAT(username,' 장년') WHERE age>=45
	
#게시판 히트수 누적 샘플
UPDATE board SET hit=hit+1 WHERE id=3

UPDATE mytable SET username=REPLACE(username, ' 장년','') WHERE age>=45

UPDATE mytable SET email=CONCAT(userid, '@a.com') WHERE email IS NULL

#데이터 삭제(delete)
DELETE FROM mytable WHERE username='김유신2'
DELETE FROM mytable WHERE idx =(SELECT MAX(idx) FROM mytable)