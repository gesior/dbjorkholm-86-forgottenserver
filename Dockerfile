FROM ubuntu:22.04

RUN apt update && \
    apt install -yq cmake build-essential ninja-build \
    libcrypto++-dev libfmt-dev libluajit-5.1-dev libmysqlclient-dev \
    libboost-iostreams-dev libboost-locale-dev libboost-system-dev libpugixml-dev

RUN apt install -yq libgmp-dev

COPY cmake /usr/src/forgottenserver/cmake/
COPY src /usr/src/forgottenserver/src/
COPY CMakeLists.txt /usr/src/forgottenserver/
WORKDIR /usr/src/forgottenserver

RUN mkdir build
RUN cd build && cmake ..
RUN cd build && make -j 32
