# Start from the official Flink image
FROM flink:1.16.1-scala_2.12

# Set environment variables
ENV ICEBERG_VERSION=1.3.0
ENV FLINK_VERSION=1.16.1
ENV HIVE_VERSION=2.3.9
ENV SCALA_VERSION=2.12
ENV MAVEN_URL=https://search.maven.org/remotecontent?filepath=

# Add the Iceberg and Hive jars to the Flink lib directory
ADD https://search.maven.org/remotecontent?filepath=org/apache/iceberg/iceberg-flink-runtime-1.16/1.3.0/iceberg-flink-runtime-1.16-1.3.0.jar /opt/flink/lib/
ADD https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-hive-2.3.9_2.12/1.16.1/flink-sql-connector-hive-2.3.9_2.12-1.16.1.jar /opt/flink/lib/

CMD ["./bin/start-cluster.sh"]

## docker run --name flink-iceberg -p 8081:8081 -it alexmerced/flink-iceberg