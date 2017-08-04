FROM elek/hadoop-hdfs-namenode:latest

ENV ENSURE_NAMENODE_DIR true

COPY hdfs-site.xml $CONF_DIR

RUN mkdir /data/namenode && chmod 777 /data/namenode
