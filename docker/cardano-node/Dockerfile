FROM ubuntu:21.04

LABEL maintainer="Meema Labs"

ENV \
DEBIAN_FRONTEND=noninteractive \
USER=ubuntu

RUN apt-get update \
    && apt-get install -y gnupg tzdata \
    && echo "UTC" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y \
    git jq bc \
    make automake rsync \
    htop curl build-essential \
    pkg-config libffi-dev libgmp-dev \
    libssl-dev libtinfo-dev libsystemd-dev \
    zlib1g-dev make g++ wget libncursesw5 libtool \
    libncurses-dev libtinfo5 autoconf

# in our AWS servers, the workdir would be /home/ubuntu
WORKDIR /root/ubuntu

COPY ./docker-build.sh .

RUN ./docker-build.sh
