from flask import Flask, render_template, jsonify
from kafka import KafkaConsumer
import threading
import json
import os

# 현재 파일 기준으로 상위 디렉토리에 있는 templates 폴더 지정
#app = Flask(__name__, template_folder=os.path.join(os.path.dirname(__file__), '..', 'templates'))

# 현재 파일 기준에 있는 templates 폴더 지정
app = Flask(__name__, template_folder='templates', static_folder='static')


""" ------------------------------------------------------------------------------------------------------
Kafka Producer               : 5초당 메시지 랜덤 생성 후 Kafka에 전송
Kafka Consumer + Flask 서버   : Kafka에서 메시지를 받아, 정상/비정상 분류, app_flask.py에서 기능 구현
Flask 웹 UI                   : 메시지 개수 표시 및 클릭 시 상세 확인 가능
------------------------------------------------------------------------------------------------------ """

normal_messages = []
abnormal_messages = []

MAX_MESSAGES = 1000
def consume_messages():
    print("Kafka consumer 시작됨...")
    consumer = KafkaConsumer(
        'test-topic',   #Kafka의 test-topic에서 메시지를 받아옴
        bootstrap_servers='localhost:9092',
        auto_offset_reset='latest',   #'earliest',  'latest'
        enable_auto_commit=True,
        group_id='flask-group',
        value_deserializer=lambda x: json.loads(x.decode('utf-8'))
    )

    for message in consumer:
        data = message.value
        print("수신:", data)

        #머신러닝 : if pred == 0 :
        if data["작업갯수"] < 10:
            data['status'] = 0
            normal_messages.append(data)
            if len(normal_messages) > MAX_MESSAGES:
                normal_messages.pop(0)  # 가장 오래된 메시지 제거
        else:
            data['status'] = 1
            abnormal_messages.append(data)
            if len(abnormal_messages) > MAX_MESSAGES:
                abnormal_messages.pop(0)

@app.route('/')
def index():
    return render_template('kafka_index.html')

@app.route('/messages/<msg_type>')
def get_messages(msg_type):
    if msg_type == 'normal':
        return jsonify(normal_messages)
    elif msg_type == 'abnormal':
        return jsonify(abnormal_messages)
    else:
        return jsonify([])

@app.route('/messages_count')
def get_counts():
    print(f"Counts 요청 - normal: {len(normal_messages)}, abnormal: {len(abnormal_messages)}")
    return jsonify({
        'normal': len(normal_messages),
        'abnormal': len(abnormal_messages)
    })

# Consumer 스레드 실행 + Flask 서버 시작
if __name__ == '__main__':
    thread = threading.Thread(target=consume_messages)
    thread.daemon = True
    thread.start()
    app.run(debug=False)