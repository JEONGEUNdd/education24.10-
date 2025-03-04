from flask import Flask, render_template,redirect, request, url_for, jsonify
import mysql.connector
import json
from datetime import datetime

app=Flask(__name__)


class EmployeeManager:
    def __init__(self):
        self.connection=None
        self.cursor=None
    
    def connect(self):
        try:
            self.connection=mysql.connector.connect(
                host="localhost",
                user="sejong",
                password="1234",
                database="employee_db"
            )
            self.cursor=self.connection.cursor(dictionary=True)
        except mysql.connector.Error as error:
            print(f"데이터베이스 연결 실패: {error}")
            
    def disconnect(self):
        if self.connection and self.connection.is_connected():
            self.cursor.close()
            self.connection.close()
            
    def get_all_employees(self):
        try:
            self.connect()
            sql="SELECT * FROM employees"
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
            sql="INSERT INTO employees (name,email,department,salary,hire_date) values (%s,%s,%s,%s,%s)"
            values=(name,email,department,salary,datetime.now().date())
            self.cursor.execute(sql,values)
            self.connection.commit()
            return True
        
        except mysql.connector.Error as error:
            print(f"직원 추가 실패: {error}")
            return False
        finally:
            self.disconnect()
    
    def get_employee_by_id(self,id):
        try:
            self.connect()
            sql="SELECT * FROM employees WHERE id=%s"
            value=(id,)
            self.cursor.execute(sql,value)
            return self.cursor.fetchone()
        
        except mysql.connector.Error as error:
            print(f"직원 조회 실패: {error}")
            return None
        finally:
            self.disconnect()
            
    def update_employee(self,id,name,email,department,salary):
        try:
            self.connect()
            sql="UPDATE employees SET name=%s, email=%s, department=%s, salary=%s WHERE id=%s "
            values=(name,email,department,salary,id)
            self.cursor.execute(sql,values)
            self.connection.commit()
            return True
        
        except mysql.connector.Error as error:
            print(f"직원 정보 수정 실패: {error}")
            return False
        finally:
            self.disconnect() 
            
    def delete_employee(self,id):    
        try:
            self.connect()
            sql="DELETE FROM employees WHERE id=%s"
            value=(id,)
            self.cursor.execute(sql,value)
            self.connection.commit()
            return True
        except mysql.connector.Error as error:
            print(f"직원 삭제 실패: {error}")
            return False
        finally:
            self.disconnect()
      
manager=EmployeeManager()  
        
@app.route('/')
def index():
    employees=manager.get_all_employees()
    return render_template('index.html', employees=employees)

@app.route('/employee/add', methods=['GET','POST'])
def add_employee():
    if request.method=='POST':
        name=request.form['name']
        email=request.form['email']
        department=request.form['department']
        salary=request.form['salary']
        if manager.insert_employee(name,email,department,salary):
            return redirect(url_for('index'))
        return "직원 추가 실패",400
    return render_template('add.html')

@app.route('/employee/<int:id>')
def view_employee(id):
    employee=manager.get_employee_by_id(id)
    return render_template('view.html',employee=employee)

@app.route('/employee/edit/<int:id>',methods=['GET','POST'])
def edit_employee(id):
    if request.method=='POST':
        name=request.form['name']
        email=request.form['email']
        department=request.form['department']
        salary=request.form['salary']
        if manager.update_employee(id,name,email,department,salary):
            return redirect(url_for('index'))
        return "직원 정보 수정 실패",400
    employee=manager.get_employee_by_id(id)
    if employee:
        return render_template('edit.html',employee=employee)
    return "직원을 찾을 수 없습니다.",404


@app.route('/employee/delete/<int:id>')
def delete_employee(id):
    if manager.delete_employee(id):
        return redirect(url_for('index'))
    return "직원 삭제 실패",400
    
if __name__=='__main__':
    app.run(host="0.0.0.0", port=80, debug=True) 
  