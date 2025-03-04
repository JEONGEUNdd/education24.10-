from flask import Flask,render_template,request,redirect,url_for,jsonify,send_from_directory
import json
from datetime import datetime
from models import EmployeeManager

app = Flask(__name__)
          
manager = EmployeeManager()

# 소수점 타입
@app.template_filter('ftype')
def ftype_filter(value):
    return "{:.0f}".format(value)

# 숫자 3자리 마다 콤마 표시
@app.template_filter('comma')
def comma_filter(value):
    return "{:,.0f}".format(value)

# 또는 한국식 원화 표시를 위해
@app.template_filter('krw')
def krw_filter(value):
    return "{:,.0f}원".format(value)

### MVC 방식

@app.route('/')
def index():
    employees = manager.get_all_employees()
    return render_template('index.html', employees=employees)

@app.route('/employee/add', methods=['GET', 'POST'])
def add_employee():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        department = request.form['department']
        salary = float(request.form['salary'])
        if manager.insert_employee(name, email, department, salary):
            return redirect(url_for('index'))
        return "직원 추가 실패", 400
    return render_template('add.html')

@app.route('/employee/<int:id>')
def view_employee(id):
    employee = manager.get_employee_by_id(id)
    return render_template('view.html',employee=employee)

@app.route('/employee/edit/<int:id>', methods=['GET', 'POST'])
def edit_employee(id):
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        department = request.form['department']
        salary = float(request.form['salary'])
        if manager.update_employee(id, name, email, department, salary):
            return redirect(url_for('index'))
        return "직원 정보 수정 실패", 400
    employee = manager.get_employee_by_id(id)
    if employee:
        return render_template('edit.html',employee=employee)
    return "직원을 찾을 수 없습니다", 404

@app.route('/employee/delete/<int:id>')
def delete_employee(id):
    if manager.delete_employee(id):
        return redirect(url_for('index'))
    return "직원 삭제 실패", 400

### API 방식

# JSON 응답에서 한글 인코딩 설정
app.config['JSON_AS_ASCII'] = False
app.json.ensure_ascii = False

# 정적파일 호출 (추후 API 단독실행시 '/api/'를 '/'로 수정하면 됨)
@app.route('/api/', defaults={'filename': 'index.html'})
@app.route('/api/<path:filename>')
def api(filename):
    return send_from_directory('static', filename)

# 전체 직원목록 가져오기 (GET 메소드)
@app.route('/api/employees', methods=['GET'])
def api_get_employees():
    employees = manager.get_all_employees()
    return jsonify(employees)

# 새로운 직원 등록 (POST 메소드)
@app.route('/api/employees', methods=['POST'])
def api_add_employee():
    data = request.json
    if manager.insert_employee(
        data['name'],
        data['email'],
        data['department'],
        float(data['salary'])
    ):
        return jsonify({"message": "Employee added successfully"}), 201
    return jsonify({"error": "Failed to add employee"}), 400

# 개별 직원정보 가져오기(수정을 위해서) (GET 메소드)
@app.route('/api/employees/<int:id>', methods=['GET'])
def api_get_employee(id):
    employee = manager.get_employee_by_id(id)
    if employee:
        return jsonify(employee)
    return jsonify({"error": "Employee not found"}), 404

# 개별 직원정보 수정하기 (PUT 메소드)
@app.route('/api/employees/<int:id>', methods=['PUT'])
def api_update_employee(id):
    data = request.json
    if manager.update_employee(
        id,
        data['name'],
        data['email'],
        data['department'],
        float(data['salary'])
    ):
        return jsonify({"message": "Employee updated successfully"})
    return jsonify({"error": "Failed to update employee"}), 400

# 직원 삭제하기(DELETE 메소드)
@app.route('/api/employees/<int:id>', methods=['DELETE'])
def api_delete_employee(id):
    if manager.delete_employee(id):
        return jsonify({"message": "Employee deleted successfully"})
    return jsonify({"error": "Failed to delete employee"}), 400

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5001, debug=True)