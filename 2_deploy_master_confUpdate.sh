#!/bin/bash

dir=`pwd`
package_dir=~/bigdatainfra_deploy/package
cluster_home=/opt
cd $package_dir

#Update configuration files
yes|cp core-site.xml hadoop-env.sh hdfs-site.xml mapred-site.xml mapred-env.sh slaves yarn-env.sh yarn-site.xml $cluster_home/components/hadoop/etc/hadoop/
yes|cp start-journal.sh mr_healch_check.sh wordcount.txt $cluster_home/components/hadoop/sbin/
chmod +x $cluster_home/components/hadoop/sbin/*
yes|cp hbase-site.xml hbase-env.sh regionservers backup-masters $cluster_home/components/hbase/conf/
yes|cp hbase_healch_check.sh hbase.shell $cluster_home/components/hbase/bin/
chmod +x $cluster_home/components/hbase/bin/*
yes|cp $dir/conf/zookeeper.list zoo.cfg zookeeper-log4j.properties $cluster_home/components/zookeeper/conf/
mv $cluster_home/components/zookeeper/conf/zookeeper-log4j.properties $cluster_home/components/zookeeper/conf/log4j.properties
yes|cp start-zookeeper.sh stop-zookeeper.sh $cluster_home/components/zookeeper/bin/
chmod +x $cluster_home/components/zookeeper/bin/*.sh
yes|cp spark-defaults.conf spark-env.sh $cluster_home/components/spark/conf/
yes|cp server.properties zookeeper.properties consumer.properties producer.properties $cluster_home/components/kafka/config
yes|cp hive-env.sh hive-default.xml hive-log4j.properties $cluster_home/components/hive/conf/
yes|cp healthcheck-cluster.sh start-cluster.sh stop-cluster.sh $cluster_home/components/utils/cluster/
chmod +x $cluster_home/components/utils/cluster/*

cp -rf $cluster_home/components/hadoop/ $cluster_home/hadoop/program
cp -rf $cluster_home/components/hbase/ $cluster_home/hbase/program
cp -rf $cluster_home/components/zookeeper/ $cluster_home/zookeeper/program
cp -rf $cluster_home/components/jdk/ $cluster_home
chown -R hadoop:hadoop $cluster_home
