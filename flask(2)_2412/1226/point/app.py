from flask import Flask, render_template, url_for, send_from_directory
from datetime import datetime
app=Flask(__name__)

menu=['index','news','services','products','contacts']
@app.route('/', methods=['GET','POST'])
def home(filename='index'):
    if filename in menu:
        return render_template(filename+'.html', menu=menu, nick_name=filename, current_time=datetime.now())
    else:
        return ""

@app.route('/news')
def news():
    return render_template('news.html',menu=menu, nick_name='news', current_time=datetime.now())


@app.route('/services')
def services():
    return render_template('services.html',menu=menu, nick_name='services', current_time=datetime.now())


@app.route('/products')
def products():
    return render_template('products.html',menu=menu, nick_name='products', current_time=datetime.now())


@app.route('/contacts')
def downloads():
    return render_template('contacts.html',menu=menu, nick_name='contacts', current_time=datetime.now())


@app.route('/images/<path:filename>')
def images(filename):
    return send_from_directory("static/images", filename)

@app.route('/css/<path:filename>')
def css(filename):
    return send_from_directory("static/css", filename)

@app.route('/js/<path:filename>')
def js(filename):
    return send_from_directory("static/js", filename)

if __name__ == '__main__':
    app.run(debug=True) 