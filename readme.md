## Apache Iceberg Playground

This container has the following Installed
- Java 11
- Scala 2 & 3
- Python 3
- Spark 3.2

## Start SparkSQL with Apache Iceberg

```
iceberg-init
```





## Start Spark Shell with Apache Iceberg

```
iceberg-spark-init
```

## Load sample data as a view

```
CREATE TEMPORARY VIEW my_data
USING csv 
OPTIONS (
  path 'sampledata/Worker_Coops.csv',
  header true,
  inferSchema true
);
```

Then to turn into a iceberg table

```
CREATE TABLE iceberg.db.worker_coop USING iceberg AS (SELECT * FROM my_data);
```

## Other Table Formats

This command will init Spark-Shell with a Hudi catalog
```
hudi-init
```

This command will init Spark-Shell with a Delta Lake Catalog
```
delta-init
```