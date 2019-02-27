# Tutorial

## Start Zoo&Kafka

```sh
  docker-compose -f zookeeper.yaml up -d
  docker-compose -f kafka.yaml up -d
```

## Kafka Tutorial

References: https://kafka.apache.org/quickstart, https://www.confluent.io/blog/hands-free-kafka-replication-a-lesson-in-operational-simplicity/

- Download the 2.1.0 release and un-tar it.

  `wget http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.1.0/kafka_2.11-2.1.0.tgz`

- Create topic

  `bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic test`

- Show topic

  ```bash
    bin/kafka-topics.sh --list --zookeeper localhost:2181
  ```
