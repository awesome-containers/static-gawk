# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

# https://ftp.gnu.org/gnu/gawk/
ARG GAWK_VERSION=5.2.1

WORKDIR /src/gawk
RUN set -xeu; \
    curl -#Lo gawk.tar.gz \
        "https://ftp.gnu.org/gnu/gawk/gawk-$GAWK_VERSION.tar.xz"; \
    tar -xvf gawk.tar.gz --strip-components=1; \
    rm -f gawk.tar.gz

ARG CFLAGS='-w -g -Os -static'
RUN set -xeu; \
    ./configure; \
    make -j"$(nproc)"; \
    strip -s -R .comment --strip-unneeded gawk; \
    chmod -cR 755 gawk; \
    chown -cR 0:0 gawk; \
    ! ldd gawk && :; \
    ./gawk --version; \
    mkdir bin; cp gawk bin/gawk; ln -f bin/gawk bin/awk

# static gawk image
FROM static-bash
COPY --from=build /src/gawk/bin/ /bin/
