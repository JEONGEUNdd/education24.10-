from flask import Flask, render_template, url_for, redirect, request, session
from flask_session import Session
from functools import wraps

app=Flask(__name__)
app.secret_key='your_secret_key'

users={
    'admin@example.com':{'password':'admin123','role':'admin'},
    'user@example.com':{'password':'user123','role':'user'},
}

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user' not in session:
            return redirect('/login')
        return f(*args, **kwargs)
    return decorated_function


def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user' not in session or session['role']!='admin':
            return "접근 권한이 없습니다", 403
        return f(*args, **kwargs)
    return decorated_function



@app.route('/')
@app.route('/login',methods=['GET','POST'])
def login():
    if request.method=='POST':
        email=request.form['email']
        password=request.form['password']
        
        if email in users and users[email]['password']==password:
            session['user']=email
            session['role']=users[email]['role']
            return redirect('/dashboard')
    return render_template('login.html')

@app.route('/dashboard')
@login_required
def dashboard():
    if session['role']=='admin':
        return render_template("admin.html")
    return render_template('user.html')


@app.route('/logout')
@login_required
def logout():
    session.pop('user',None)
    session.pop('role',None)
    return redirect('/login')


if __name__ == '__main__':
    app.run(port=5001,debug=True) 