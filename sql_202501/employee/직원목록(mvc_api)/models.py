import mysql.connector
from datetime import datetime

class EmployeeManager:
    def __init__(self):
        self.connection = None
        self.cursor = None
    
    def connect(self):
        try:
            self.connection = mysql.connector.connect(
                host="10.0.66.31",
                user="sejong",
                password="1234",
                database="employee_db"
            )
            self.cursor = self.connection.cursor(dictionary=True)
            
        except mysql.connector.Error as error:
            print(f"데이터베이스 연결 실패: {error}")

    def disconnect(self):
        if self.connection and self.connection.is_connected():
            self.cursor.close()
            self.connection.close()
            
    def get_all_employees(self):
        try:
            self.connect()
            sql = "SELECT * FROM employees"
            self.cursor.execute(sql)
            return self.cursor.fetchall()
        except mysql.connector.Error as error:
            print(f"직원 조회 실패: {error}")
            return []
        finally:
            self.disconnect()
    
    def insert_employee(self,name,email,department,salary):
        try:
            self.connect()
            sql = "INSERT INTO employees (name,email,department,salary,hire_date) values (%s,%s,%s,%s,%s)"
            values = (name,email,department,salary,datetime.now().date())            
            self.cursor.execute(sql, values)
            
            #values = [(name,email,department,salary,datetime.now().date()),(name,email,department,salary,datetime.now().date())]
            #self.cursor.executemany(sql, values)            
            
            self.connection.commit()
            return True
        except mysql.connector.Error as error:
            self.connection.rollback()
            print(f"직원 추가 실패: {error}")
            return False
        finally:
            self.disconnect()
   
    def get_employee_by_id(self, id):
        try:
            self.connect()
            sql = "SELECT * FROM employees WHERE id = %s"
            value = (id,) # 튜플 1개 일때
            self.cursor.execute(sql, value)
            return self.cursor.fetchone()
        except mysql.connector.Error as error:
            print(f"직원 조회 실패: {error}")
            return None
        finally:
            self.disconnect()
    
    def update_employee(self,id,name,email,department,salary):
        try:
            self.connect()
            sql = """UPDATE employees 
                     SET name = %s, email = %s, department = %s, salary = %s
                     WHERE id = %s
                     """
            values = (name,email,department,salary,id)            
            self.cursor.execute(sql, values)
            self.connection.commit()
            return True
        except mysql.connector.Error as error:
            self.connection.rollback()
            print(f"직원 정보 수정 실패: {error}")
            return False
        finally:
            self.disconnect()
    
    def delete_employee(self, id):
        try:
            self.connect()
            sql = "DELETE FROM employees WHERE id = %s"
            value = (id,) # 튜플 1개 일때
            self.cursor.execute(sql, value)
            self.connection.commit()
            return True
        except mysql.connector.Error as error:
            self.connection.rollback()
            print(f"직원 삭제 실패: {error}")
            return False
        finally:
            self.disconnect()