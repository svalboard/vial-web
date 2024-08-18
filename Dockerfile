FROM ubuntu:22.04

ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt-get install -y python3 build-essential libffi-dev git curl wget zlib1g-dev zip unzip

RUN apt-get install -y gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 20 && \
  update-alternatives --config python

COPY . /vial-web

WORKDIR /vial-web

RUN git clone https://github.com/svalboard/via-keymap-precompiled.git

RUN echo 'source "/vial-web/emsdk/emsdk_env.sh"' >> $HOME/.bash_profile

RUN ./fetch-emsdk.sh
RUN ./fetch-deps.sh
RUN ./build-deps.sh
