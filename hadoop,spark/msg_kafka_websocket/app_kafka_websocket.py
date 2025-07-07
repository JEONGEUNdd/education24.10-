#최상단에 두기
from gevent import monkey
monkey.patch_all()

from flask import Flask, render_template
from flask_socketio import SocketIO
from kafka import KafkaConsumer
import threading
import json
import os


app = Flask(__name__, template_folder='templates', static_folder='static')

#socketio = SocketIO(app, cors_allowed_origins="*")  # CORS 허용
socketio = SocketIO(app, async_mode='gevent')

normal_messages = []
abnormal_messages = []
MAX_MESSAGES = 1000

def consume_messages():
    print("Kafka consumer 시작됨...")
    consumer = KafkaConsumer(
        'test-topic',
        bootstrap_servers='kafka:9092',
        auto_offset_reset='latest',
        enable_auto_commit=True,
        group_id='flask-group',
        value_deserializer=lambda x: json.loads(x.decode('utf-8'))
    )

    for message in consumer:
        data = message.value
        print("수신:", data)

        if data["작업갯수"] < 10:
            data['status'] = 0
            normal_messages.append(data)
            if len(normal_messages) > MAX_MESSAGES:
                normal_messages.pop(0)
        else:
            data['status'] = 1
            abnormal_messages.append(data)
            if len(abnormal_messages) > MAX_MESSAGES:
                abnormal_messages.pop(0)

        # 실시간 웹소켓으로 클라이언트에 전송
        socketio.emit('MY_CMD_MSG_UPDATE',
                      {'normal_count': len(normal_messages),
                            'abnormal_count': len(abnormal_messages),
                            'new_message': data
                        })

@app.route('/')
def index():
    # 초기 로드 시 기존 메시지 개수도 템플릿 변수로 전달 (필요시)
    return render_template('kafka_websocket_index.html',
                           normal_count=len(normal_messages),
                           abnormal_count=len(abnormal_messages))


if __name__ == '__main__':
    thread = threading.Thread(target=consume_messages)
    thread.daemon = True
    thread.start()

    socketio.run(app, debug=False, allow_unsafe_werkzeug=True)
