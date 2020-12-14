FROM postgres:11

RUN apt update && apt-get install -y sudo nano openssh-server openssh-sftp-server

COPY ./scripts /docker-entrypoint-initdb.d
