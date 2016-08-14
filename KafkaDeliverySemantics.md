There is a great, extensive blog post by the creator of the direct kakfa stream approach (Cody) here http://blog.cloudera.com/blog/2015/03/exactly-once-spark-streaming-from-apache-kafka/.

In general, reading the Kafka delivery semantics section, the last part says:

So effectively Kafka guarantees at-least-once delivery by default and allows the user to implement at most once delivery by disabling retries on the producer and committing its offset prior to processing a batch of messages. Exactly-once delivery requires co-operation with the destination storage system but Kafka provides the offset which makes implementing this straight-forward.
This basically means "we give you at least once out of the box, if you want exactly once, that's on you". Further, the blog post talks about the guarantee of "exactly once" semantics you get from Spark with both approaches (direct and receiver based, emphasis mine):

Second, understand that Spark does not guarantee exactly-once semantics for output actions. When the Spark streaming guide talks about exactly-once, it’s only referring to a given item in an RDD being included in a calculated value once, in a purely functional sense. Any side-effecting output operations (i.e. anything you do in foreachRDD to save the result) may be repeated, because any stage of the process might fail and be retried.
Also, this is what the Spark documentation says about receiver based processing:

The first approach (Receiver based) uses Kafka’s high level API to store consumed offsets in Zookeeper. This is traditionally the way to consume data from Kafka. While this approach (in combination with write ahead logs) can ensure zero data loss (i.e. at-least once semantics), there is a small chance some records may get consumed twice under some failures.
This basically means that if you're using the Receiver based stream with Spark you may still have duplicated data in case the output transformation fails, it is at least once.

In my project I use the direct stream approach, where the delivery semantics depend on how you handle them. This means that if you want to ensure exactly once semantics, you can store the offsets along with the data in a transaction like fashion, if one fails the other fails as well.

I recommend reading the blog post (link above) and the Delivery Semantics in the Kafka documentation page http://kafka.apache.org/documentation.html#semantics. To conclude, I definitely recommend you look into the direct stream approach.
