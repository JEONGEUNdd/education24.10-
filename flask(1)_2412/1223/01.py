from flask import Flask
app=Flask(__name__)

@app.route('/')
@app.route('/home')

def home():
    return 'Hello World'

#동적 url:string, int, float(함수의 인자로 사용)
@app.route('/user/<username>/<int:user_id>')
def user_profile2(username="홍길동", user_id="123"):
    return f'사용자: {username}, 사용자 ID: {user_id}'

if __name__=='__main__':
    app.run(debug=True)
    
