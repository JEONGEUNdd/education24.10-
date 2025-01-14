from flask import Flask, request, make_response
from datetime import datetime, timedelta
app=Flask(__name__)


#쿠키설정
@app.route('/set_cookie')
def set_cookie():
    resp=make_response('쿠키 생성되었습니다.')
    expire_time=datetime.now()+timedelta(days=1)
    resp.set_cookie('user_id','hongged')
    # resp.set_cookie(
    #     'user_id',
    #     'user123',
    #     max_age=60*60*24,  #쿠키 유효기간:1일 (초단위)
    #     expires=expire_time.strftime('%a, %d %b %Y %H:%M:%S GMT')#만료날짜: 1일후
    #     path='/',  #쿠키가 유효한 경로
    #     domain='localhost',
    #     secure=True,
    #     httponly=True  #JavaScript에서 접근 불가
    # )
    return resp
    
#쿠키 수정
@app.route('/modify_cookie')
def modify_cookie():
    resp=make_response('쿠키 수정되었습니다.')
    resp.set_cookie('user_id','leess')
    return resp
    
    
#쿠키 가져오기
@app.route('/get_cookie')
def get_cookie():
    user_id=request.cookies.get('user_id')
    return f'사용자ID:{user_id}'


#쿠키 삭제
@app.route('/delete_cookie')
def delete_cookie():
    resp=make_response('쿠키 삭제되었습니다.')
    resp.delete_cookie('user_id')
    return resp
    
    
#모든 쿠키 삭제
@app.route('/delete_all_cookies')
def delete_all_cookies():
    resp=make_response('쿠키가 모두 삭제되었습니다.')
    cookies=request.cookies
    for cookie in cookies:
        resp.delete_cookie(cookie)
        resp.set_cookie(cookie,'',expires=0)
    return resp


if __name__ == '__main__':
    app.run(port=5003,debug=True)