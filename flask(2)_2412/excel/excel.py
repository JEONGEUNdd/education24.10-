import pandas as pd
import mysql.connector

#엑셀파일 읽기
# df=pd.read_excel(r'C:\Users\enjoy\Flask_202412\file.xlsx')
df=pd.read_excel(r'C:\xampp\htdocs\file.xlsx')


#MySQL 데이터베이스 연결 
connection=mysql.connector.connect(
    host='localhost',
    user='root',
    password='2345',
    database='mydb'
)
cursor=connection.cursor()
  

for i, row in df.iterrows():
    if i==0:
        continue
    print(tuple(row))
   
   
#테이블 생성
sql='''
CREATE TABLE IF NOT EXISTS score (
    idx INT(10) UNSIGNED NOT NULL,
    name VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    dept VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    p_score TINYINT(4) NULL DEFAULT '0',
    m_score TINYINT(4) NULL DEFAULT '0',
    f_score TINYINT(4) NULL DEFAULT '0',
    h_score TINYINT(4) NULL DEFAULT '0',
    PRIMARY KEY (idx)
)
'''
cursor.execute(sql)


#데이터 추가
# insert_query='''
# INSERT INTO score (idx, name, dept, p_score, m_score, f_score, h_score)
# VALUES(%s,%s,%s,%s,%s,%s,%s)
# '''

insert_query = '''
INSERT INTO score (idx, name, dept, p_score, m_score, f_score, h_score)
VALUES (%s, %s, %s, %s, %s, %s, %s)
'''


for i, row in df.iterrows():
    if i==0:
        continue
    cursor.execute(insert_query, tuple(row))
connection.commit()

#연결종료
cursor.close()
connection.close()

