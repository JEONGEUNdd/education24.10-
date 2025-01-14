from flask import Flask,render_template,request
app=Flask(__name__)

@app.route('/')
def index():
    tasks=[
        {'title':'중요한 작업','priority':'high'},
        {'title':'일반 작업','priority':'medium'},
        {'title':'간단한 작업','priority':'low'},
        {'title':'완료된 작업','status':'completed'},
    ]
    return render_template('tasks.html',tasks=tasks)

if __name__=='__main__':
    app.run(port=5001,debug=True)
 