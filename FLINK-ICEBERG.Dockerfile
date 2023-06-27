# Start from the official Flink image
FROM flink:1.16.1-scala_2.12

# Set environment variables
ENV ICEBERG_VERSION=1.3.0
ENV FLINK_VERSION=1.16.1
ENV HIVE_VERSION=2.3.9
ENV SCALA_VERSION=2.12
ENV MAVEN_URL=https://search.maven.org/remotecontent?filepath=

# Add the Iceberg and Hive jars to the Flink lib directory
# Download the jars and move them to the directory

RUN curl -L https://search.maven.org/remotecontent?filepath=org/apache/iceberg/iceberg-flink-runtime-1.16/1.3.0/iceberg-flink-runtime-1.16-1.3.0.jar -o /opt/flink/lib/iceberg-flink-runtime-1.16-1.3.0.jar

RUN curl -L https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-hive-2.3.9_2.12/1.16.1/flink-sql-connector-hive-2.3.9_2.12-1.16.1.jar -o /opt/flink/lib/flink-sql-connector-hive-2.3.9_2.12-1.16.1.jar

# RUN curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.5/hadoop-common-3.3.5.jar -o /opt/flink/lib/hadoop-common-3.3.5.jar

RUN curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/2.8.3/hadoop-common-2.8.3.jar -o /opt/flink/lib/hadoop-common-2.8.3.jar

RUN curl -L https://repo.maven.apache.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar -o /opt/flink/lib/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar 

# RUN curl -L https://repo1.maven.org/maven2/org/apache/flink/flink-s3-fs-hadoop/1.16.2/flink-s3-fs-hadoop-1.16.2.jar -o /opt/flink/lib/flink-s3-fs-hadoop-1.16.2.jar

# RUN curl -L https://repo1.maven.org/maven2/org/apache/flink/flink-s3-fs-presto/1.16.2/flink-s3-fs-presto-1.16.2.jar -o /opt/flink/lib/flink-s3-fs-presto-1.16.2.jar

# RUN curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.8.5/hadoop-aws-2.8.5.jar -o /opt/flink/lib/hadoop-aws-2.8.5.jar

RUN curl -L https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.20.18/bundle-2.20.18.jar -o /opt/flink/lib/bundle-2.20.18.jar

RUN apt update && apt install -y nano

RUN echo "fs.s3a.endpoint: http://storage:9000" >> /opt/flink/conf/flink-conf.yaml && \
    echo "fs.s3a.access.key: admin" >> /opt/flink/conf/flink-conf.yaml && \
    echo "fs.s3a.secret.key: password" >> /opt/flink/conf/flink-conf.yaml && \
    echo "fs.s3a.path.style.access: true" >> /opt/flink/conf/flink-conf.yaml \
    echo "fs.s3a.region: us-east-1" >> /opt/flink/conf/flink-conf.yaml

## Install Minio Client
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc && \
    chmod +x mc && \
    mv mc /usr/local/bin && \
    mc alias set myminio http://storage:9000 admin password --api S3v4


CMD ["./bin/start-cluster.sh"]

## docker run --name flink-iceberg -p 8081:8081 -it alexmerced/flink-iceberg