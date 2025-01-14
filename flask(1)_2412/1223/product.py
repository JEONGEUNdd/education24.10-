# http://127.0.0.1:5000/products?search=%EB%85%B8%ED%8A%B8%EB%B6%81&min_price=1000000&max_price=2000000&sort=price_desc
from flask import Flask,render_template_string,render_template, request, url_for
from urllib.parse import unquote, quote #url디코딩, 인코딩
app=Flask(__name__)

@app.route('/products')
def product_list():
    params={k:unquote(v) for k,v in request.args.items()}
    
    # for k, v in request.args.items():
    # return request.args
    # return '상품 목록'

# with app.test_request_context():
#     print(url_for('product_list'))
#     print(url_for('product_list', search='노트북'))
#     print(url_for('product_list',
#                   search='노트북',
#                   min_price=1000000,
#                   max_price=2000000,
#                   sort='price_desc'))


    html='''
    <h2>상품 리스트</h2>
    <table border="1">
        <tr><th>파라미터</th><th>값</th></tr>
        {% for k, v in params.items() %}
        <tr><td>{{k}}</td><td>{{v}}</td></tr>
        {% endfor %}
    </table>
    '''
    
    # html='''
    # <h2>상품 리스트</h2>
    # <table border="1">
    #     <tr><th>파라미터</th><th>값</th></tr>
    #     {% for key, value in request.args.items() %}
    #     <tr><td>{{key}}</td><td>{{value}}</td></tr>
    #     {% endfor %}
    # </table>
    # '''
    
    #html스트링(텍스트)를 템플릿 파일로
    return render_template_string(html,params=params)

    #html파일을 템플릿 파일로
    # return render_template('product1.html',params3=params)
    
if __name__=='__main__':
    app.run(debug=True)