#log
mkdir -p /opt/logs/hadoop
mkdir -p /opt/logs/yarn
mkdir -p /opt/logs/hbase
mkdir -p /opt/logs/zookeeper
mkdir -p /opt/logs/spark
mkdir -p /opt/logs/hive
mkdir -p /opt/logs/kafka/server

chown -R hadoop:hadoop /opt

#Hadoop Agent node
mkdir -p /data01/data
mkdir -p /data02/data
chown -R hadoop:hadoop /data01
chown -R hadoop:hadoop /data02
