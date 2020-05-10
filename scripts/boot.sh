#!/bin/bash
set -x

# stop all old containers
docker stop hello_sql

# remove all old containers
docker rm hello_sql

# remove old image
docker image rm hello_sql:latest

# build a new image
docker build -t hello_sql:latest .

# create & run container from image
docker run \
  -itd \
  --name hello_sql \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  -p 7654:5432 \
  hello_sql

# sleep to wait until psql available
sleep 2

# exec into container's shell
docker exec -it hello_sql psql -Upostgres
