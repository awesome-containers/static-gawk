# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15

FROM ghcr.io/awesome-containers/alpine-build-essential:3.17 AS build

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
    chmod -cR 755 gawk; \
    chown -cR 0:0 gawk; \
    ! ldd gawk && :; \
    ./gawk --version; \
    mkdir bin; cp gawk bin/gawk; ln -f bin/gawk bin/awk

# static gawk image
FROM ghcr.io/awesome-containers/static-bash:$STATIC_BASH_VERSION
COPY --from=build /src/gawk/bin/ /bin/
