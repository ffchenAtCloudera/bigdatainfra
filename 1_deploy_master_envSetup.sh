#!/bin/bash

dir=`pwd`
#prepare dev env

yum -y install rsync
yum -y install openssh-clients
yum -y install expect
yum -y install lrzsz

#download packages and configuration files
mkdir -p ~/bigdatainfra_deploy/package
cd ~/bigdatainfra_deploy/package
#hadoop
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/hadoop/hadoop-dist/2.6.0-cdh5.4.1/hadoop-dist-2.6.0-cdh5.4.1.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/core-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hadoop-env.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hdfs-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/mapred-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/slaves
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/yarn-env.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/yarn-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/mr_healch_check.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/wordcount.txt
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/mapred-env.sh

#zookeeper
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/zookeeper/zookeeper-dist/3.4.5-cdh5.4.1/zookeeper-dist-3.4.5-cdh5.4.1.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/zoo.cfg
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/zookeeper-log4j.properties
#hbase
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/hbase/hbase-dist/1.0.0-cdh5.4.1-bin/hbase-dist-1.0.0-cdh5.4.1-bin.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hbase-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hbase-env.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/regionservers
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/backup-masters
#spark
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/spark/spark-dist/1.3.0-cdh5.4.1/spark-dist-1.3.0-cdh5.4.1.tgz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/spark-defaults.conf
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/spark-env.sh
#kafka
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/kafka/kafka-dist/0.8.2.0-kafka-1.3.0/kafka-dist-0.8.2.0-kafka-1.3.0.tgz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/server.properties
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/zookeeper.properties
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/producer.properties
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/consumer.properties
#hive
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/hive/hive-packaging/1.1.0-cdh5.4.1/hive-packaging-1.1.0-cdh5.4.1-bin.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hive-env.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hive-default.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hive-log4j.properties
#jdk
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/tools/jdk-7u75-linux-x64.tar.gz


#master components home
mkdir -p /opt/components
tar zxf jdk-7u75-linux-x64.tar.gz -C /opt/components/
tar zxf zookeeper-dist-3.4.5-cdh5.4.1.tar.gz -C /opt/components/
tar zxf hadoop-dist-2.6.0-cdh5.4.1.tar.gz -C /opt/components/
tar zxf hbase-dist-1.0.0-cdh5.4.1-bin.tar.gz -C /opt/components/
tar zxf spark-dist-1.3.0-cdh5.4.1.tgz -C /opt/components/
tar zxf kafka-dist-0.8.2.0-kafka-1.3.0.tgz -C /opt/components/
tar zxf hive-packaging-1.1.0-cdh5.4.1-bin.tar.gz -C /opt/components/
mv /opt/components/*hive* /opt/components/hive
mv /opt/components/hadoop* /opt/components/hadoop
mv /opt/components/zookeeper* /opt/components/zookeeper
mv /opt/components/hbase* /opt/components/hbase
mv /opt/components/spark* /opt/components/spark
mv /opt/components/kafka* /opt/components/kafka
mv /opt/components/jdk* /opt/components/jdk

pwd
cd $dir
pwd
#create user and passwdless for ssh localhost
groupadd hadoop
useradd hadoop -g hadoop -p hadoop
rm -rf /home/hadoop/.ssh
su hadoop -l -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa"
su hadoop -l -c "cp /home/hadoop/.ssh/id_rsa.pub /home/hadoop/.ssh/authorized_keys"

#environment variables setup
cat /home/hadoop/.bashrc bashrc >> /home/hadoop/.bashrc

sudo chown -R hadoop:hadoop /opt
sudo chown -R hadoop:hadoop /home/hadoop
#mkdir for cluster deploy
./master_deploy_mkdir.sh
