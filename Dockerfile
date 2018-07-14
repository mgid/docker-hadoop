FROM openjdk:8-jre-alpine

ARG HADOOP_VERSION
ENV HADOOP_VERSION ${HADOOP_VERSION}
ENV HADOOP_ROOT_LOGGER="WARN,console"
ENV YARN_ROOT_LOGGER="WARN,console"
ENV PATH="/opt/bin:${PATH}"

RUN mkdir -p /opt/logs && \
    wget -q http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -O - | tar -xz -C /opt --strip-components=1 && \
    apk add --quiet --no-cache bash

COPY ./conf/* /opt/etc/hadoop/

RUN mkdir -p /data/dfs/data /data/dfs/name && \
    hdfs namenode -format 2> /dev/null

EXPOSE 50010 50020 50070 50075

COPY entrypoint.sh /sbin/

ENTRYPOINT ["entrypoint.sh"]
