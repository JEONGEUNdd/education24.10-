# http://127.0.0.1:5000/board?page=2&category=notice&search=%EA%B3%B5%EC%A7%80&sort=recent
from flask import Flask, url_for, render_template_string, url_for, request, render_template
from urllib.parse import unquote, quote #url디코딩, 인코딩

app=Flask(__name__)

@app.route('/board')
def board():
    params={k:unquote(v) for k,v in request.args.items()}
    
    # html='''
    # <h2>보드 리스트</h2>
    # <table border="1">
    #     <tr><th>파라미터</th><th>값</th></tr>
    #     {% for k, v in params.items() %}
    #     <tr><td>{{k}}</td><td>{{v}}</td></tr>
    #     {% endfor %}
    # </table>
    # '''
    # return render_template_string(html, paramsboard=params)
    
    return render_template('board1.html',paramsboard=params)

if __name__=='__main__':
    app.run(debug=True)