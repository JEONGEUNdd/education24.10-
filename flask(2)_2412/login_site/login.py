from flask import Flask, render_template, url_for, redirect,request,session
from flask_session import Session
from datetime import timedelta

app=Flask(__name__)
app.secret_key="your_fixed_secret_key"

app.config['SESSION_PERMANENT']=True  #영구유지 여부
app.config['PERMANENT_SESSION_LIFETIME']=timedelta(hours=1)
app.config['SESSION_TYPE']='filesystem' #세션 저장 방식
app.config['SESSION_USE_SIGNER']=True
app.config['SECRET_KEY']='your_secret_key'

#flask_session 초기화
Session(app)

users={
    'a@b.com':{'password':'1234'}
}

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/login', methods=['GET','POST'])
def login():
    if request.method=='POST':
        email=request.form['email']
        password=request.form['password']
        if email in users and users[email]['password']==password:
            session['user']=email
            return redirect(url_for('welcome'))
        return f'로그인 실패<br><br><a href="/">Home</a>'
    
    return render_template('login.html')


@app.route('/welcome')
def welcome():
    if 'user' in session:
        return f'환영합니다.{session.get('user')})<br><br><a href="{url_for('home')}">Home</a>'
    return redirect(url_for('login'))

@app.route('/logout') 
def logout():
    session.pop('user',None)  #user세션만 삭제
    #session.clear()  #모든 세션 정보 삭제
    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run(debug=True)


