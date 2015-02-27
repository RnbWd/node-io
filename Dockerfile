FROM debian:wheezy

MAINTAINER David Wisner dwisner6@gmail.com

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    build-essential \
    pkg-config \
    git \
    python \
  && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION 0.10.36
ENV NPM_VERSION 2.6.0

RUN buildDeps='curl' \
  && set -x \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
  && apt-get purge -y --auto-remove $buildDeps \
  && npm install -g npm@"$NPM_VERSION" \
  && npm cache clear

CMD [ "node" ]


