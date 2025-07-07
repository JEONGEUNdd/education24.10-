#Kafka 없이 작동하는 WebSocket 구조
"""
pip install flask_socketio
pip install eventlet  XXXX

pip install gevent gevent-websocket


threading으로 메시지를 생성하고 socketio.emit()으로 클라이언트에 푸시
socketio.run()으로 WebSocket 서버 실행
"""

#최상단에 위치  :::  eventlet
# import eventlet
# eventlet.monkey_patch()

#최상단에 위치 ::: gevent gevent-websocket
from gevent import monkey
monkey.patch_all()

from flask import Flask, render_template
from flask_socketio import SocketIO
import threading
import time
import random
from datetime import datetime

app = Flask(__name__)
#socketio = SocketIO(app, cors_allowed_origins="*")
socketio = SocketIO(app, async_mode='gevent')

normal_messages = []
abnormal_messages = []
MAX_MESSAGES = 1000

def generate_messages():
    workers = ['kim']
    while True:
        count = random.randint(1, 15)
        message = {
            "작업자": random.choice(workers),
            "작업일시": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "작업갯수": count
        }
        print("생성:", message)

        if count < 10:
            message['status'] = 0
            normal_messages.append(message)
            if len(normal_messages) > MAX_MESSAGES:
                normal_messages.pop(0)
        else:
            message['status'] = 1
            abnormal_messages.append(message)
            if len(abnormal_messages) > MAX_MESSAGES:
                abnormal_messages.pop(0)

        socketio.emit('message_update', {
            'normal_count': len(normal_messages),
            'abnormal_count': len(abnormal_messages),
            'new_message': message
        })

        time.sleep(5)

@app.route('/')
def index():
    return render_template('websocket_index.html')

if __name__ == '__main__':
    thread = threading.Thread(target=generate_messages)
    thread.daemon = True
    thread.start()

    socketio.run(app, debug=False, allow_unsafe_werkzeug=True)

