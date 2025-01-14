from flask import Flask,request
app=Flask(__name__)

@app.route('/form.html',methods=['GET','POST'])
def subname():
    if request.method=='POST':
        username=request.form.get('username')
        userid=request.form.get('userid')
        
        if userid:
            return f"어서오세요 {username}님, 사용자 ID: {userid}"
        else:
            return 'UserId값이 없습니다.'
    # return render_template("form.html") form.html파일 따로 만들어 놓으면 이거만 실행 가능
    return '''
    <form method="POST">
        <label for="username">사용자 이름:</label>
        <input type="text" id="username" name="username" required="">
        <br>
        <label for="userid">사용자 ID:</label>
        <input type="text" id="userid" name="userid">
        <br>
        <input type="submit" value="전송">
    </form>
    '''
if __name__=='__main__':
    app.run(debug=True)
    
    # request.args.get('userid',5)
    # request.args['userid']:GET방식
    # userid=request.args.get('userid') 
    
    # request.form['userid']:POST방식
    # return f'<h1>어서오세요 {username}님</h1>'
    # return request.args
