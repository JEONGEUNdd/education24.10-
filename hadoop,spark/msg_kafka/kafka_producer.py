# ----------------------------------
# pip install kafka-python
# ----------------------------------
import json
import random
import time
from datetime import datetime
from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

workers = ['kim']

while True:
    count = random.randint(1, 15)
    message = {
        "작업자": random.choice(workers),
        "작업일시": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "작업갯수": count
    }
    print("전송:", message)   # 5초마다 작업자, 작업일시, 작업갯수 정보를 Kafka에 전송함
    producer.send('test-topic', value=message)   #Kafka 서버로 메시지를 보냄 (test-topic이라는 큐에)
    time.sleep(5)