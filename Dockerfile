FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install -y openssh-client wget