from flask import Flask, render_template, url_for, redirect,request
from datetime import datetime

app=Flask(__name__)

survey_results=[]

@app.route('/', methods=['GET', 'POST'])
def survey():
    if request.method == 'POST':
        q0 = request.form['q0']
        q1 = request.form['q1']
        q2 = request.form['q2']
        response_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        survey_results.append({
            'q0': q0,
            'q1': q1,
            'q2': q2,
            'response_time': response_time
        })
        
        return redirect(url_for('results'))
    return render_template('survey.html')

@app.route('/results')
def results():
    return render_template('results.html', results=survey_results)

if __name__ == '__main__':
    app.run(debug=True)
    