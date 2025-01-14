import mysql.connector

#MySQL 데이터베이스 연결 
connection=mysql.connector.connect(
    host='localhost',
    user='root',
    password='2345',
    database='mydb2'
)
cursor=connection.cursor()

sql="SELECT * FROM mytable WHERE userid like 'kim%'"
cursor.execute(sql)

print(cursor.fetchall())

cursor.close()
connection.close()

