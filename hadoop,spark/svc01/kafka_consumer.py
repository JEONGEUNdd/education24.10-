from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col
from pyspark.sql.types import StructType, StringType, DoubleType
import os

# Kafka 연동에 필요한 JAR 명시적으로 등록
os.environ["PYSPARK_SUBMIT_ARGS"] = "--jars /opt/bitnami/spark/ext-jars/* pyspark-shell"

spark = SparkSession.builder \
    .appName("KafkaToHive") \
    .enableHiveSupport() \
    .config("spark.jars", "/opt/bitnami/spark/ext-jars/*") \
    .getOrCreate()

# print(">> spark.jars =", spark.conf.get("spark.jars"))


#Kafka에서 스트리밍 데이터 읽기
raw_df = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "kafka:9092") \
    .option("subscribe", "sales_topic") \
    .load()
# sales_topic에서 Kafka 메시지 실시간 수신
schema = StructType().add("id", StringType()).add("category", StringType()).add("amount", DoubleType())

df = raw_df.selectExpr("CAST(value AS STRING)") \
    .select(from_json(col("value"), schema).alias("data")) \
    .select("data.*")

# 콘솔 출력
query_console = df.writeStream \
    .format("console") \
    .outputMode("append") \
    .start()


#Parquet로 저장 (→ Hive 외부 테이블 연동)
query_parquet = df.writeStream \
    .outputMode("append") \
    .format("parquet") \
    .option("path", "/user/hive/warehouse/sales_kafka_tbl/") \
    .option("checkpointLocation", "hdfs://hadoop-master:9000/checkpoints/sales_kafka_tbl/") \
    .start()

query_console.awaitTermination()
query_parquet.awaitTermination()
