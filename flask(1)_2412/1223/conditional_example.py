from flask import Flask, render_template
app=Flask(__name__)

#1. 조건문
# @app.route('/conditional/<int:value>')
# def conditional_example(value):
#     return render_template('conditional_example.html', template_variable=value)

#2. 숫자리스트
# @app.route('/loop/<int:value>')
# def loop_example(value):
#     return render_template('loop_example.html',template_variable=value)

# #3. 구구단
# @app.route('/loop2/<int:value>')
# def loop_example(value):
#     return render_template('loop2_example.html',template_variable=value)

# #4. 딕셔너리 항목
# @app.route('/dictionary/<int:value>')
# def dict_example():
#     template_dict={'banana':1, "apple":2, "orange":3, "grape":4}
#     sort_by=request.args.get('sort_by', 'key')
#     reverse=request.args.get('reverse','false')=='true'
    
#     return render_template('dictionary_example.html',template_dict=template_dict, sort_by=sort_by, reverse=reverse)

@app.route('/index2')
def index2():
    return render_template("index2.html")

if __name__=='__main__':
    app.run(debug=True)    