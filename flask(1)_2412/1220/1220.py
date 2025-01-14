from flask import Flask
# set FLASK_APP=app.py  #윈도우 환경변수
app=Flask(__name__)

@app.route('/')  # /를 home()함수와 연결:라우팅
@app.route('/home')  #/home을 home2()함수와 연결

def home():
    return 'Hello, World!'

@app.route('/user/<string:user_name>/<int:user_id>')
def user(user_name,user_id):
    return f'{user_name}({user_id})님 안녕하세요'

if __name__ == '__main__':
    app.run(debug=True)
    
  