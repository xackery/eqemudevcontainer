#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

# https://github.com/microsoft/vscode-dev-containers/tree/v0.101.1/containers/ubuntu-18.04-git/.devcontainer/Dockerfile
FROM ubuntu:18.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install --no-install-recommends build-essential \
    gcc-5 g++-5 libtool cmake curl debconf-utils \
    git git-core libio-stringy-perl liblua5.1 \
    liblua5.1-dev libluabind-dev libmysql++ \
    libperl-dev libperl5i-perl libjson-perl libsodium-dev \
    libmysqlclient-dev libssl-dev lua5.1 \
    minizip make mariadb-client locales \
    nano open-vm-tools unzip uuid-dev iputils-ping \
    zlibc wget \
    gdb valgrind \
# Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium-dev_1.0.11-2_amd64.deb -O /tmp/libsodium-dev.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/libs/libsodium/libsodium18_1.0.11-2_amd64.deb -O /tmp/libsodium18.deb
RUN dpkg -i /tmp/libsodium*.deb
# Cleanup after ourselves
RUN rm -f /tmp/libsodium-dev.deb
RUN rm -f /tmp/libsodium18.deb

# fix locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND=dialog
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8