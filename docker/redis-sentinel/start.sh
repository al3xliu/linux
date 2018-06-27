#!/bin/bash

set -e

# Run docker master
docker run \
--name="redis-master" \
--network=host \
-d redis:3.2

docker run --name="redis-slave1" \
--network=host \
-v `pwd`/conf/slave1.conf:/usr/local/etc/redis/redis.conf \
-d redis:3.2 \
redis-server /usr/local/etc/redis/redis.conf --slaveof 127.0.0.1 6379

docker run --name="redis-slave2" \
--network=host \
-v ./conf/slave2.conf:/usr/local/etc/redis/redis.conf \
-d redis:3.2 \
redis-server /usr/local/etc/redis/redis.conf --slaveof 192.168.15.119 6379

docker run -d --name='sentinel' \
--network=host \
-e SENTINEL_DOWN_AFTER=5000 \
-e SENTINEL_FAILOVER=5000 \
-e SENTINEL_QUORUM=1 \
-e MASTER_IP=127.0.0.1 \
sentinel
