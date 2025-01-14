from flask import Flask, render_template,url_for,request, redirect, send_from_directory
app=Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')


@app.route('/support')
def support():
    return render_template('Support.html')


@app.route('/features')
def features():
    return render_template('Features.html')

@app.route('/downloads')
def downloads():
    return render_template('Downloads.html')


@app.route('/contacts')
def contacts():
    return render_template('Contacts.html')

# @app.route('/images/<path:filename>')
# def images(filename):
#     return send_from_directory("static/images", filename)

# @app.route('/css/<path:filename>')
# def css(filename):
#     return send_from_directory("static/css", filename)

# @app.route('/js/<path:filename>')
# def js(filename):
#     return send_from_directory("static/js", filename)


if __name__ == '__main__':
    app.run(debug=True)