# Kafka connector

The Kafka pipeline is simple : 

```Kafka -> Sarama -> Consumer -> ConsumerProcesor -> Sink -> Ingester (external)```

1. Data is consumed by a custom Sarama consumer.
2. Each topic is associated with a unique consumer processor.
3. When the consumer receives a message, it is routed to the corresponding consumer processor.
4. The message traverses through the processor and ultimately reaches the sink.
5. The sink component receives a certain number of messages.
6. Once the buffer is full, the sink sends these messages to the next step in the pipeline, which is the ingester.
