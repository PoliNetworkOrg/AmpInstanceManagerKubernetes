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
    apt-get install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
    apt-transport-https && \
    # Add CubeCoders repository and key
    apt-key adv --fetch-keys http://repo.cubecoders.com/archive.key && \
    apt-add-repository "deb http://repo.cubecoders.com/ debian/" && \
    apt-get update && \
    # Just download (don't actually install) ampinstmgr
    apt-get install -y --no-install-recommends --download-only ampinstmgr && \
    # Extract ampinstmgr from downloaded package
    mkdir -p /tmp/ampinstmgr && \
    dpkg-deb -x /var/cache/apt/archives/ampinstmgr_*.deb /tmp/ampinstmgr && \
    mv /tmp/ampinstmgr/opt/cubecoders/amp/ampinstmgr /usr/local/bin/ampinstmgr && \
    apt-get -y clean && \
    apt-get -y autoremove --purge && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*
    
ENTRYPOINT ["/opt/entrypoint/main.sh"]
