# Docker Simple tutorial

## Image Related

- Download Image

```bash
docker pull mongo:3.4
```

- List All Images

```bash
docker images
```

- Inspect One Image

```bash
docker image inspect mongo:3.4
```

Use this command to check which dir you can volume.

- Delete Image

```bash
docker rmi -f mongo:3.4
```


## Container Related

- Run a Container

```bash
docker run -d --name "mongo" --restart=always -p 27017:27017 -v ~/data/mongo:/data/db mongo:3.4
```

Here list the explain of the options:

  + -d running as a daemon
  + --name container name, whatever you like
  + -v mount volume to the dir in the container, the first part is source dir on your pc, and the 2nd part is dst part in the container.
  + -p expose a port so you can connect to this container from outside. as -v the first is source and the second is dst
  + --restart=always always restart when container shutdown

- Access in a container

```bash
docker exec -it mongo bash
```

- List all running containers

```bash
docker ps
```

- List all containers

```bash
docker ps -a
```

- Stop Container

```bash
docker stop mongo
```

- Start Container

```bash
docker start mongo
```

- Delete Container

```bash
docker rm -f mongo
```
