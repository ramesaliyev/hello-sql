FROM postgres:12

ADD samples/ /tmp/samples
ADD samples/dvdrental/dvdrental.tar.gz /tmp/samples

COPY samples/restore.sh /docker-entrypoint-initdb.d/restore.sh

RUN chmod -R 777 /tmp/samples
RUN chmod +x /docker-entrypoint-initdb.d/restore.sh