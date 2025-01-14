from flask import Flask, render_template, url_for, redirect, request,session, make_response
from flask_session import Session
from datetime import timedelta

app=Flask(__name__)

users = {
    'user1': 'password1',
    'user2': 'password2'
}

@app.route('/')
def home():
    username=request.cookies.get('username')
    if username: 
        return f'안녕하세요, {username}님 <a href="/logout">로그아웃</a>'
    return '안녕하세요! <a href="/login">로그인</a>'


@app.route('/login', methods=['GET','POST'])
def login():
    if request.method=='POST':
        username=request.form['username']
        password=request.form['password']
        
        if username in users and users[username]==password:
            resp=make_response(redirect(url_for('home')))
            resp.set_cookie('username',username)
            return resp
        else:
            return '''
            로그인 실패:사용자 이름이나 비밀번호를 확인하세요<br><br>
            <a href='/login'>로그인</a>
            '''
    return render_template('login.html')


@app.route('/logout')
def logout():
    resp=make_response(redirect(url_for('home')))
    resp.delete_cookie('username')
    return resp


#쿠키설정
@app.route('/set_cookie')
def set_cookie():
    resp=make_response('쿠키 생성되었습니다.')
    expire_time=datetime.now()+timedelta(days=1)
    resp.set_cookie('user1','password1')
    return resp
    



if __name__ == '__main__':
    app.run(debug=True) 