FROM ubuntu:24.04 as builder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang curl git g++

RUN git clone https://github.com/bkaradzic/bx

ADD . /bimg
WORKDIR /bimg

RUN /bx/tools/bin/linux/genie --with-tools --gcc=linux-gcc gmake && \
    make -C .build/projects/gmake-linux-gcc/ config=release64 texturec

FROM ubuntu:24.04
COPY --from=builder /bimg/.build/linux64_gcc/bin/texturecRelease /texturec
