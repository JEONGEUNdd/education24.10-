
CREATE EXTERNAL TABLE IF NOT EXISTS test_kafka_tbl (
    jworker STRING,
    rdate STRING,
    amount DOUBLE
)
STORED AS PARQUET
LOCATION '/user/hive/warehouse/test_kafka_tbl/';
