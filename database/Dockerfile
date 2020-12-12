FROM postgres:11

RUN apt update
RUN apt-get install -y sudo
RUN apt-get install -y nano
RUN apt-get -y install openssh-server openssh-sftp-server
COPY ./scripts /docker-entrypoint-initdb.d
