FROM ubuntu:latest
WORKDIR /app

RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && \
    apt-get -y install build-essential curl git libdbus-1-dev libbluetooth-dev libnl-genl-3-dev libibverbs-dev libssl-dev libsmi2-dev libcap-ng-dev libpcap-dev automake autoconf p7zip-full && \
    apt-get -y autoremove

COPY . .

RUN touch .devel configure && \
    ./configure --with-crypto=no --prefix=/tmp && \
    make -s && \
    7z a -mx9 tcpdump.7z tcpdump

RUN ls -la

ENTRYPOINT ["./tcpdump"]
