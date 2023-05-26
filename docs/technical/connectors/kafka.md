# Kafka connector

The Kafka pipeline is simple : 

`Kafka -> Sarama -> Consumer -> ConsumerProcesor -> Sink -> Ingester (external)`
- Data is consumed by a custom Sarama consumer.
- Each topic is associated with a unique consumer processor.
- When the consumer receives a message, it is routed to the corresponding consumer processor.
- The message traverses through the processor and ultimately reaches the sink.
- The sink component receives a certain number of messages.
- Once the buffer is full, the sink sends these messages to the next step in the pipeline, which is the ingester.
