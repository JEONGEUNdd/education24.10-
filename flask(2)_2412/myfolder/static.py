from flask import Flask, render_template, send_from_directory, jsonify
app=Flask(__name__)

@app.route('/api/data')
def get_data():
    dynamic_data={
        'message':'Hello from the backend!',
        'items':['Item 1','Item 2','Item 3']
    }
    return jsonify(dynamic_data)

@app.route('/')
@app.route('/<path:filename>')
def serve_static(filename='index.html'):
    return send_from_directory('myfolder',filename)


if __name__ == '__main__':
    app.run(port=5003,debug=True)