FROM ghcr.io/toltec-dev/python:v1.4

RUN pip3 install okp

WORKDIR /opt/
RUN apt update
RUN apt-get install -y wget unzip git
RUN wget https://github.com/koreader/koxtoolchain/releases/download/2021.12/kobo.zip
RUN unzip kobo.zip
RUN tar -xzf kobo.tar.gz
RUN rm kobo.zip kobo.tar.gz
 
ARG NGCONFIG="arm-kobo-linux-gnueabihf"
ARG CHOST="arm-linux-gnueabihf"

ENV ARCH=arm \
    CHOST="$CHOST" \
    CROSS_COMPILE="$CHOST-" \
    PATH="$PATH:/opt/x-tools/$NGCONFIG/bin" \
    PKG_CONFIG_LIBDIR="/opt/x-tools/$NGCONFIG/$NGCONFIG/sysroot/usr/lib/pkgconfig:/opt/x-tools/$NGCONFIG/$NGCONFIG/sysroot/lib/pkgconfig:/opt/x-tools/$NGCONFIG/$NGCONFIG/sysroot/opt/lib/pkgconfig" \
    PKG_CONFIG_SYSROOT_DIR="/opt/x-tools/$NGCONFIG/$NGCONFIG/sysroot" \
    SYSROOT="/opt/x-tools/$NGCONFIG/$NGCONFIG/sysroot" \
    NGCONFIG="$NGCONFIG" \
    TARGET_PREFIX="$CHOST"

# vim: syntax=dockerfile
