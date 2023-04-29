FROM ubuntu:22.04

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
    apt-get install -y tmux socat unzip git wget

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
    # --------------------
    # Dependencies for Minecraft:
    openjdk-17-jre-headless \
    openjdk-11-jre-headless \
    openjdk-8-jre-headless \
    # --------------------
    && \
    apt-get -y clean && \
    apt-get -y autoremove --purge && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# Set Java default
RUN update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

RUN wget -q https://repo.cubecoders.com/ampinstmgr-latest.tgz
RUN tar -xf ampinstmgr-latest.tgz -C /
RUN rm ampinstmgr-latest.tgz

COPY entrypoint.sh /amp/entrypoint.sh
RUN chmod +x /amp/entrypoint.sh

# Change executer to non user
RUN useradd -u 7999 -m amp
RUN chown -R amp .
USER amp

ENTRYPOINT ["/bin/bash", "/amp/entrypoint.sh"]
