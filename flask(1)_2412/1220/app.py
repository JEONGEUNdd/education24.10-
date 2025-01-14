from flask import Flask
# set FLASK_APP=app.py  #윈도우 환경변수
app=Flask(__name__)

@app.route('/')  # /를 home()함수와 연결:라우팅
@app.route('/home')  #/home을 home2()함수와 연결

def home():
    return 'Hello, World!'

# @app.route('/home')
# def home2():
#     return 'Hello, MyHome World!!!'

@app.route('/user')
def user():
    return '<b>Hello</b>, User!!! 하이~'

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
    
    #[host]
    #host='127.0.0.1' (기본값)-localhost
    #host='0.0.0.0' (모든 대역대 ip에서 접근)
    #host='10.0.66.200' (특정 ip에서만 접근)
    
    # [debug]
    # True:오류정보 표시, 소스 수정시 재시작
    
    #[reload]
    # True: 소스 수정시 재시작
    # False:(기본값)
    
    #[port]
    # 5000(기본값)
    
# #새 프로젝트 시작
# cd_my project

# #가상환경 생성
# python -m venv venv

# 가상환경 활성화
# venv\Scripts\activate

#버전별 의존성 설치
# pip install -r requirements.txt

# 작업완료후 비활성화
# deactivate
    
