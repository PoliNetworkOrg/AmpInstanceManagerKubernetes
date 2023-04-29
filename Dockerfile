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

# Create the ping_http script
RUN echo '#!/bin/bash\n\
\n\
url="$1"\n\
count="${2:-4}"\n\
\n\
for i in $(seq 1 $count); do\n\
  output=$(curl -s -o /dev/null -w "%{time_total}" -m 1 "$url")\n\
  if [ $? -eq 0 ]; then\n\
    echo "Reply from $url: time=${output}s"\n\
  else\n\
    echo "Request timeout for $url"\n\
  fi\n\
  sleep 1\n\
done' > /usr/local/bin/ping_http

# Make the script executable
RUN chmod +x /usr/local/bin/ping_http

# Create an alias for ping
RUN echo 'alias ping=ping_http' >> ~/.bashrc

# Change executer to non user
RUN useradd -u 7999 -m amp
RUN chown -R amp .
USER amp

COPY entrypoint.sh /amp/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/amp/entrypoint.sh"]
