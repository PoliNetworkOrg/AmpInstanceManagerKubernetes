FROM ubuntu:20.04

ENV UID=1000
ENV GID=1000
ENV TZ=Etc/UTC
ENV PORT=8080
ENV USERNAME=admin
ENV PASSWORD=password
ENV MODULE=ADS
ENV IPBINDING=0.0.0.0

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y tmux socat unzip git wget curl iputils-ping

WORKDIR /amp

# Install AMP dependencies
RUN ls -al /usr/local/bin/
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    # --------------------
    # Dependencies for AMP:
    tmux \
    git \
    socat \
    unzip \
    procps \
    curl \
    # --------------------
    # Dependencies for Minecraft:
    openjdk-17-jre-headless \
    openjdk-11-jre-headless \
    openjdk-8-jre-headless

# Set Java default
RUN update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

RUN wget -q https://repo.cubecoders.com/ampinstmgr-latest.tgz
RUN tar -xf ampinstmgr-latest.tgz -C /
RUN rm ampinstmgr-latest.tgz

# Set ownership and permissions for /home/amp/.ampdata
RUN mkdir -p /home/amp/.ampdata && \
    chown -R amp:amp /home/amp/.ampdata && \
    chmod -R 755 /home/amp/.ampdata


COPY entrypoint.sh /amp/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/amp/entrypoint.sh"]
