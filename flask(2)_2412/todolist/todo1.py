from flask import Flask, render_template, url_for, redirect,request
from datetime import datetime
app=Flask(__name__)
todos=[]

@app.route('/',methods=['GET','POST'])
def todo():
    if request.method=='POST':
        title=request.form['title']
        due_date=request.form['due_date']
        priority=request.form['priority']
        todos.append({
            'title':title,
            'due_date':due_date,
            'priority':priority,
            'completed':False,
            'regdate':datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        })
        return redirect(url_for("todo"))
    return render_template('todo.html',todos=todos)


@app.route('/append',methods=['POST'])
def append():
    if request.method=='POST':
        title=request.form['title']
        due_date=request.form['due_date']
        priority=request.form['priority']
        todos.append({
            'title':title,
            'due_date':due_date,
            'priority':priority,
            'completed':False,
            'regdate':datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        })
        return redirect(url_for("todo"))
    
@app.route('/toggle/<int:index>')
def toggle(index):
    todos[index]['completed']=not todos[index]['completed']
    return redirect(url_for("todo"))

if __name__ == '__main__':
    app.run(debug=True) 