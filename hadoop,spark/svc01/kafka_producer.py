
from kafka import KafkaProducer
import json
import time
import random
from datetime import datetime
producer = KafkaProducer(
    bootstrap_servers='kafka:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
) 


#Kafka에 메시지 전송 (Producer)
#categories = ['A', 'B', 'C', 'D']
for i in range(100):
    data = {
        '작업자': str(i),
        '작업일시': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        '작업갯수': count
    }
    producer.send('sales_topic', value=data)  # Kafka 토픽에 전송
    producer.flush()  # 전송 즉시 반영
    print(f"Sent: {data}")
    time.sleep(3)  
