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

RUN wget -q https://repo.cubecoders.com/ampinstmgr-latest.tgz
RUN tar -xf ampinstmgr-latest.tgz -C /
RUN rm ampinstmgr-latest.tgz
RUN systemctl enable ampinstmgr.service && systemctl enable ampfirewall.service && systemctl enable ampfirewall.timer && systemctl enable amptasks.service && systemctl enable amptasks.timer && systemctl start ampfirewall.timer && systemctl start amptasks.timer
    
# Change executer to non user
RUN useradd -u 7999 -m amp
RUN chown -R amp .
USER amp

RUN ampinstmgr quickstart

ENTRYPOINT ["/opt/entrypoint/main.sh"]
