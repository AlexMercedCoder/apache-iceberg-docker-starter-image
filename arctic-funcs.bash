## $1 Arctic Project ID
## $2 Arctic Auth Token

arctic-spark () {
    spark-shell --packages org.apache.iceberg:iceberg-spark3-runtime:0.13.1,com.amazonaws:aws-java-sdk-pom:1.10.34,org.apache.hadoop:hadoop-aws:2.7.2,org.projectnessie:nessie-spark-extensions:0.20.1 \
 --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions  \
 --conf spark.sql.catalog.arctic=org.apache.iceberg.spark.SparkCatalog \
 --conf spark.sql.catalog.arctic.warehouse=$3 \
 --conf spark.sql.catalog.arctic.catalog-impl=org.apache.iceberg.nessie.NessieCatalog \
 --conf spark.sql.catalog.arctic.uri=https://nessie.test1.dremio.site/v1/projects/$1 \
 --conf spark.sql.catalog.arctic.ref=main \
 --conf spark.sql.catalog.arctic.authentication.type=BEARER \
 --conf spark.sql.catalog.arctic.authentication.token=$2 \
 --conf spark.sql.catalog.arctic.cache-enabled=false
}

arctic-spark-sql () {
    spark-sql --packages org.apache.iceberg:iceberg-spark3-runtime:0.13.1,com.amazonaws:aws-java-sdk-pom:1.10.34,org.apache.hadoop:hadoop-aws:2.7.2,org.projectnessie:nessie-spark-extensions:0.20.1 \
 --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions  \
 --conf spark.sql.catalog.arctic=org.apache.iceberg.spark.SparkCatalog \
 --conf spark.sql.catalog.arctic.warehouse=$3 \
 --conf spark.sql.catalog.arctic.catalog-impl=org.apache.iceberg.nessie.NessieCatalog \
 --conf spark.sql.catalog.arctic.uri=https://nessie.test1.dremio.site/v1/projects/$1 \
 --conf spark.sql.catalog.arctic.ref=main \
 --conf spark.sql.catalog.arctic.authentication.type=BEARER \
 --conf spark.sql.catalog.arctic.authentication.token=$2 \
 --conf spark.sql.catalog.arctic.cache-enabled=false
}

arctic-pyspark () {
    pyspark --packages org.apache.iceberg:iceberg-spark3-runtime:0.13.1,com.amazonaws:aws-java-sdk-pom:1.10.34,org.apache.hadoop:hadoop-aws:2.7.2,org.projectnessie:nessie-spark-extensions:0.20.1 \
 --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions  \
 --conf spark.sql.catalog.arctic=org.apache.iceberg.spark.SparkCatalog \
 --conf spark.sql.catalog.arctic.warehouse=$3 \
 --conf spark.sql.catalog.arctic.catalog-impl=org.apache.iceberg.nessie.NessieCatalog \
 --conf spark.sql.catalog.arctic.uri=https://nessie.test1.dremio.site/v1/projects/$1 \
 --conf spark.sql.catalog.arctic.ref=main \
 --conf spark.sql.catalog.arctic.authentication.type=BEARER \
 --conf spark.sql.catalog.arctic.authentication.token=$2 \
 --conf spark.sql.catalog.arctic.cache-enabled=false
}