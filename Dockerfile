FROM crystallang/crystal:0.35.1

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD shard* $INSTALL_PATH/

RUN shards install

ADD . $INSTALL_PATH

RUN crystal build --release --stats --progress --define logs ./src/application.cr -o bin/freegeoliteip

RUN crystal build --release --stats --progress --define logs ./src/jobs.cr -o bin/jobs

CMD "./bin/freegeoliteip"