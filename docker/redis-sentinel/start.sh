#!/bin/bash

set -e

# Run docker master
docker run --name="redis-master" -p 6379:6379 -d redis:3

docker run --name="redis-slave1" -p 6380:6379 -d redis:3 redis-server --slaveof 192.168.1.5 6379

docker run --name="redis-slave2" -p 6381:6379 -d redis:3 redis-server --slaveof 192.168.1.5 6379

docker run -d --name='sentinel' \
-p 26379:26379 \
-e SENTINEL_DOWN_AFTER=5000 \
-e SENTINEL_FAILOVER=5000 \
sentinel
