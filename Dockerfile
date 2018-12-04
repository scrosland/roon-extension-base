FROM node:8-alpine
WORKDIR /app
ENV DATA /app/extensions
COPY bin/* /app/
COPY lib/* /app/lib/
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories \
  && apk add --no-cache \
    g++ \
    gcc \
    git \
    linux-headers \
    make \
    python \
    moreutils@testing \
  && ln -s /app/check-for-updates.sh /etc/periodic/daily/95-check-for-updates \
  && npm -g config set user root \
  && npm install -g node-gyp \
  && mkdir $DATA

CMD ["sh"]
