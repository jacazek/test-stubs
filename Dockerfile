FROM gradle:6.7.1-jdk15
ENV WIREMOCK_VERSION 2.27.2
ENV CONTRACTS_PATH /home/contracts
ENV STUBS_PATH /home/demo/build/stubs/META-INF/com.example/demo/0.0.1-SNAPSHOT

RUN apt-get update \
    && apt-get install -y inotify-tools curl \
    && mkdir -p /var/wiremock/lib/ \
    && wget https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-jre8-standalone/$WIREMOCK_VERSION/wiremock-jre8-standalone-$WIREMOCK_VERSION.jar \
    -O /var/wiremock/lib/wiremock-jre8-standalone.jar

WORKDIR /home/demo
COPY ./ /home/demo

RUN mkdir -p $STUBS_PATH

VOLUME $CONTRACTS_PATH
EXPOSE 8080 8443

WORKDIR $STUBS_PATH
ENTRYPOINT ["/home/demo/docker-entrypoint.sh"]
CMD java $JAVA_OPTS -cp /var/wiremock/lib/*:/var/wiremock/extensions/* com.github.tomakehurst.wiremock.standalone.WireMockServerRunner