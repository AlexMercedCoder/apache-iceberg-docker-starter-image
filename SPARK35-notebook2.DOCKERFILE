## Starting from Ubuntu
FROM ubuntu:22.04

## Create a Non-Root User
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends dialog apt-utils
RUN apt-get update && apt-get -y install sudo wget curl nano
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Switch to Non-Root User
USER docker

## Set Home to Workdir
WORKDIR /home/docker/

## Install TZData
RUN DEBIAN_FRONTEND=noninteractive TZ="America/New York" sudo -E apt-get -y install tzdata

## Install Git
RUN sudo apt-get install git -y

## Install Java 11 and Set JAVA_HOME
RUN sudo apt-get update && sudo apt-get install -y openjdk-11-jdk
# Set JAVA_HOME for all users
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' | sudo tee /etc/profile.d/jdk.sh
RUN echo 'export PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/profile.d/jdk.sh

## Load JAVA_HOME variable in current shell for subsequent commands
RUN . /etc/profile.d/jdk.sh

## Install Python 2, 3, and Pip/Pip3
RUN sudo apt-get install python2 python3 python3-pip -y

## Install Coursier
RUN curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | gzip -d > cs
RUN chmod +x cs && sudo mv cs /usr/local/bin

## Install Scala and Scala compiler via Coursier
RUN cs setup -y
RUN cs install scala3
RUN cs install scala3-compiler
# Update PATH for Coursier-installed tools
RUN echo 'export PATH=$PATH:$HOME/.local/share/coursier/bin' >> ~/.bashrc

## Install Apache Spark
RUN sudo apt-get install -y python3 python3-dev
RUN wget https://archive.apache.org/dist/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz
RUN sudo mkdir /opt/spark
RUN sudo tar -xf spark-3.5.0-bin-hadoop3.tgz -C /opt/spark --strip-components=1
RUN sudo chmod -R 777 /opt/spark
# Setting environment variables for Spark
RUN echo 'export SPARK_HOME=/opt/spark' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin' >> ~/.bashrc
RUN echo 'export PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc
RUN echo 'SPARK_MASTER_HOST=0.0.0.0' >> ~/.bashrc

## Install PySpark
RUN pip install jupyterlab notebook pyspark

EXPOSE 8888
EXPOSE 8080
EXPOSE 8081
EXPOSE 7077
EXPOSE 4040
EXPOSE 18080

## Start Container
CMD ~/.local/bin/jupyter lab --ip=0.0.0.0 --port=8888