FROM node:8-alpine
WORKDIR /app
ENV DATA /app/extensions
COPY check-for-updates.sh /app
COPY update-and-start.sh /app
RUN apk add --no-cache \
    g++ \
    gcc \
    git \
    linux-headers \
    make \
    python \
  && ln -s check-for-updates.sh /etc/periodic/daily/. \
  && npm -g config set user root \
  && npm install -g node-gyp \
  && mkdir $DATA

CMD ["sh"]
