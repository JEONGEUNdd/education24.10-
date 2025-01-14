from flask import Flask,url_for,request
app=Flask(__name__)

@app.route('/')
def home():
    return '홈페이지'

@app.route('/about')
def aboutfunc():
    return '정보 페이지'

@app.route('/redirect')
def redirect_to_about():
    return f'<a href="{url_for("aboutfunc")}">정보 페이지로 이동</a>'
    # return f'<a href="/about">정보 페이지로 이동</a>'
    
@app.route('/go_to_user/<username>')
def go_to_user(username):
    return f'<a href="{url_for("user_profile",username=username)}">{username}의 프로필로 이동</a>'

@app.route('/user/<username>/<int:user_id>')
def user_profile2(username, user_id):
    return f'사용자: {username}, 사용자 ID: {user_id}'

@app.route('/go_to_user/<username>/<int:user_id>')
def go_to_user2(username, user_id):
    return f'<a href="{url_for("user_profile2", username=username, user_id=user_id)}">{username}의 프로필로 이동</a>'

# [url_for]
    # /:리소스 경로 정의
        # /user/홍길동
        # 매개변수 형태가 <username>식일 때
    # ?: 추가정보 전달
        # /search?q=Flask
        # 매개변수 형태가 /search처럼 없으면서 값을 q=Flask형태로 넘길 때


@app.route('/search')
def search():
    search_term=request.args.get('search_term','')  #get방식으로 넘어온 값 받아오기
    # search_term=request.form['search_term']  #post방식으로 넘겨온 값 받을 때
    return f'검색어: {search_term}'

@app.route('/search_link')
def search_link():
    # return f'<a href="{url_for("search", q="Flask")}">Flask 검색하기</a>'
    return'''
        <form action="/search" method="get">
            <input type="text" name="search_term"
            placeholder="검색어를 입력하세요">
            <input type="submit" value="검색">
        </form>
    '''

@app.route('/etc')
def etc():
    return '''
    <h1>이건 h1 제목</h1>
    <p>이건 p 본문</p>
    <a target="_blank" href="https://flask.palletsprojects.com">Flask 홈페이지 바로가기</a> 
    '''


if __name__=='__main__':
    app.run(debug=True)

