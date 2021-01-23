FROM crystallang/crystal:0.35.1-alpine

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD shard* $INSTALL_PATH/

RUN shards install

ADD . $INSTALL_PATH

RUN crystal build --release --stats --progress ./src/application.cr -o bin/freegeoliteip

CMD "./bin/freegeoliteip -D logs"