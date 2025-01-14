from flask import Flask,render_template,request
app=Flask(__name__)

@app.route('/')
def home():
    return render_template('emojis.html',emojis=emojis)

#이모지 딕셔너리
emojis = {
    'trophy': '🏆',
    'star': '⭐',
    'heart': '❤️',
    'check': '✅',
    'warning': '⚠️',
    'rocket': '🚀',
    'fire': '🔥',
    'clock': '⏰',
    'smile': '😊',
    'thumbs_up': '👍',
    'new': '🆕',
    'pencil': '✏️'
}
if __name__=='__main__':
    app.run(port=5002,debug=True)