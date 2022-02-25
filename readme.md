## Apache Iceberg Playground

This container has the following Installed
- Java 11
- Scala 2 & 3
- Python 3
- Spark

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
CREATE TABLE local.db.worker_coop USING iceberg AS (SELECT * FROM my_data);
```