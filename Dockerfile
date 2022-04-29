FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang curl git g++

## Add source code to the build stage.
RUN git clone https://github.com/bkaradzic/bx 

ADD . /bimg
WORKDIR /bimg

RUN make linux

# Package Stage
FROM ubuntu:20.04

COPY --from=builder /bimg/.build/linux64_gcc/bin/texturecRelease /texturec
