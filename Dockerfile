FROM debian:bullseye-slim as base

# must be version >= v0.11.0
ARG CORE_VERSION=22.0
ARG ARCH=x86_64
ARG PLATFORM=linux
ARG SHAS=https://bitcoincore.org/bin/bitcoin-core-$CORE_VERSION/SHA256SUMS
ENV CORE_VERSION $CORE_VERSION

RUN mkdir -p /tmp/downloads \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
                       ca-certificates \
                       curl \
 && rm -rf /var/lib/apt/lists/* \
 && cd /tmp/downloads \
 && curl -O https://bitcoin.org/bin/bitcoin-core-$CORE_VERSION/bitcoin-$CORE_VERSION-$ARCH-$PLATFORM-gnu.tar.gz \
 && curl -O $SHAS

RUN cd /tmp/downloads \
 && grep "$(sha256sum bitcoin-22.0-x86_64-linux-gnu.tar.gz)" SHA256SUMS \
 && tar xvzf bitcoin-$CORE_VERSION-x86_64-linux-gnu.tar.gz \
 && install -m 0755 -o root -g root -t /usr/local/bin bitcoin-$CORE_VERSION/bin/* \
 && rm -rf /tmp/downloads


###


FROM debian:bullseye-slim as bitcoiner

RUN useradd -m -U muhuser

WORKDIR /home/muhuser
USER muhuser

COPY --from=base /usr/local/bin /usr/local/bin

CMD [ "/usr/local/bin/bitcoind" ]
