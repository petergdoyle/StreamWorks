from kafka import KafkaConsumer
import sys

# To consume latest messages and auto-commit offsets
consumer = KafkaConsumer('splash_csv',
                         group_id='python-converter-group',
                         bootstrap_servers=['localhost:9092'])
for message in consumer:
# message value and key are raw bytes -- decode if necessary!
# e.g., for unicode: `message.value.decode('utf-8')`
    try:
        print ("%s:%d:%d: key=%s value=%s" % (message.topic, message.partition,message.offset, message.key,message.value))
    except:
        print("Unexpected error:", sys.exc_info()[0])
