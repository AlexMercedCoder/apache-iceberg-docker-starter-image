## Starting from Ubuntu
FROM ubuntu:20.04

## Create a Non-Root User
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends dialog apt-utils
RUN apt-get update && apt-get -y install sudo && apt-get install wget -y && apt-get install curl -y
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Switch to Non-Root User
USER docker

## Set Home to Workdir
WORKDIR /home/docker/

## Install TZData
RUN TZ="America/New York" sudo -E apt-get -y install tzdata

## Install Git
RUN sudo apt install git -y

## Install Java 11 for Spark
RUN sudo apt-get install openjdk-11-jdk -y

## Insall Coursier
RUN curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | gzip -d > cs
RUN sudo chmod +x cs 
RUN ./cs setup -y
RUN sudo ./cs install scala3
RUN sudo ./cs install scala3-compiler
RUN echo 'PATH=$PATH:~/.local/share/coursier/bin' >> ~/.bashrc
RUN . ~/.bashrc

## Install Apache Spark
RUN sudo apt-get install python3 python3-dev -y
RUN sudo wget https://archive.apache.org/dist/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz
RUN sudo mkdir /opt/spark
# RUN sudo tar -xvzf spark-3.3.0-bin-hadoop3.2.tgz -C /opt/spark
RUN sudo tar -xf spark-3.2.1-bin-hadoop3.2.tgz -C /opt/spark --strip-component 1
RUN sudo chmod -R 777 /opt/spark
RUN echo 'SPARK_HOME=/opt/spark' >> ~/.bashrc
RUN echo 'PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin' >> ~/.bashrc
RUN echo 'PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc
RUN . ~/.bashrc

##COPY Sample Datafiles
COPY ./sampledata /home/docker/sampledata

## Iceberg Setup
COPY ./hudi-init.bash /home/docker/
COPY ./delta-init.bash /home/docker/
COPY ./iceberg-spark-init.bash /home/docker/
COPY ./iceberg-init.bash /home/docker/
RUN echo 'alias iceberg-init="source /home/docker/iceberg-init.bash"' >> ~/.bashrc
RUN echo 'alias iceberg-spark-init="source /home/docker/iceberg-spark-init.bash"' >> ~/.bashrc
RUN echo 'alias hudi-init="source /home/docker/hudi-init.bash"' >> ~/.bashrc
RUN echo 'alias delta-init="source /home/docker/delta-init.bash"' >> ~/.bashrc
RUN mkdir warehouse
RUN . ~/.bashrc

## Start Container
ENTRYPOINT bash