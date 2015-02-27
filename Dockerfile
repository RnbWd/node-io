FROM buildpack-deps:wheezy-curl

MAINTAINER David Wisner dwisner6@gmail.com

RUN gpg --keyserver pool.sks-keyservers.net \
  --recv-keys 846ca8ed78d63926a5f75e46653d173f1773241a43b65c0148eb492248a5efd2 DD8F2338BAE7501E3DD5AC78C273792F7D83545D

ENV IOJS_VERSION 1.4.1

RUN curl -SLO "https://iojs.org/dist/v$IOJS_VERSION/iojs-v$IOJS_VERSION-linux-x64.tar.gz" \
  && curl -SLO "https://iojs.org/dist/v$IOJS_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " iojs-v$IOJS_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "iojs-v$IOJS_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "iojs-v$IOJS_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc

CMD [ "iojs" ]



