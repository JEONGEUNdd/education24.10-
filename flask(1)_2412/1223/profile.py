from flask import Flask, url_for
app=Flask(__name__)

@app.route('/profile/<username>')
def profile(username):
    return '프로필'

with app.test_request_context():  #서버실행없이 결과 테스트 함수
    # print(url_for('profile', page=1))
    # print(url_for('profile', name='홍길동',age=25))
    print(url_for('profile', username="lee"))
    print(url_for('profile', username="hong", age=25))
    
    print(url_for('static', filename='style.css'))   #정적(외부)파일 참조
    
    