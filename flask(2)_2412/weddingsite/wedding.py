from flask import Flask, render_template, url_for, redirect,request
from datetime import datetime

app=Flask(__name__)
memos=[]

@app.route('/',methods=['GET','POST'])
def memo():
    if request.method=='POST':
        name=request.form['name']
        content=request.form['content']
        memos.append({
            'name':name,
            'content':content,
            'regdate': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        })
        return redirect(url_for("memo"))
    memos_sorted = sorted(memos, key=lambda x: x['regdate'], reverse=True)
    return render_template('wedding.html',memos=memos_sorted)


if __name__ == '__main__':
    app.run(debug=True)
    
    