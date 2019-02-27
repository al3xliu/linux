# Filebeat

references:
[https://www.elastic.co/guide/en/beats/filebeat/current/running-on-docker.html]
[https://www.elastic.co/guide/en/beats/filebeat/master/kafka-output.html]

## Pull

docker pull docker.elastic.co/beats/filebeat:6.6.1

## Download configuration template

curl -L -O https://raw.githubusercontent.com/elastic/beats/6.6/deploy/docker/filebeat.docker.yml


## Start

```
docker run -d \
  --name=filebeat \
  --user=root \
  --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  docker.elastic.co/beats/filebeat:6.6.1 filebeat -e -strict.perms=false \
```
