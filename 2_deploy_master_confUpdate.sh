cd ~/bigdatainfra_deploy/package

#Update configuration files
yes|cp core-site.xml hadoop-env.sh hdfs-site.xml mapred-site.xml mapred-env.sh slaves yarn-env.sh yarn-site.xml /opt/components/hadoop/etc/hadoop/
yes|cp mr_healch_check.sh wordcount.txt /opt/components/hadoop/bin/
chmod +x /opt/components/hadoop/bin/mr_healch_check.sh
yes|cp hbase-site.xml hbase-env.sh regionservers backup-masters /opt/components/hbase/conf/
yes|cp zoo.cfg zookeeper-log4j.properties /opt/components/zookeeper/conf/
mv /opt/components/zookeeper/conf/zookeeper-log4j.properties /opt/components/zookeeper/conf/log4j.properties
yes|cp spark-defaults.conf spark-env.sh /opt/components/spark/conf/
yes|cp server.properties zookeeper.properties consumer.properties producer.properties /opt/components/kafka/config
yes|cp hive-env.sh hive-default.xml hive-log4j.properties /opt/components/hive/conf/

cp -rf /opt/components/hadoop /opt/
cp -rf /opt/components/jdk /opt/
chown -R hadoop:hadoop /opt
