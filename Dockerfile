FROM ubuntu:20.04

ENV UID=1000
ENV GID=1000
ENV TZ=Etc/UTC
ENV PORT=8080
ENV USERNAME=admin
ENV PASSWORD=password
ENV LICENCE=notset
ENV MODULE=ADS
ENV IPBINDING=0.0.0.0

RUN apt-get update && \
    apt-get install -y tmux socat unzip git wget iputils-ping

RUN ping -c 4 google.com

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
    iputils-ping \
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

RUN ping -c 4 google.com
RUN /opt/cubecoders/amp/ampinstmgr --CreateInstance $MODULE ADS01 $IPBINDING $PORT $USERNAME $PASSWORD $LICENCE


# Change executer to non user
RUN useradd -u 7999 -m amp
RUN chown -R amp .
USER amp

COPY entrypoint.sh /amp/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/amp/entrypoint.sh"]
