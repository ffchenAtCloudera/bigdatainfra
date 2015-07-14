#log
mkdir -p /opt/logs/hadoop
mkdir -p /opt/logs/yarn
mkdir -p /opt/logs/hbase
mkdir -p /opt/logs/zookeeper
mkdir -p /opt/logs/spark
mkdir -p /opt/logs/hive
mkdir -p /opt/logs/kafka
mkdir -p /opt/hbase/pids
mkdir -p /opt/hadoop/pids

chown -R hadoop:hadoop /opt

#Hadoop Agent node
mkdir -p /data/disk1/data
mkdir -p /data/disk2/data
mkdir -p /data/disk3/data
mkdir -p /data/disk4/data
mkdir -p /data/disk5/data
mkdir -p /data/disk6/data
mkdir -p /data/disk7/data
mkdir -p /data/disk8/data
chown -R hadoop:hadoop /data/disk1/data
chown -R hadoop:hadoop /data/disk2/data
chown -R hadoop:hadoop /data/disk3/data
chown -R hadoop:hadoop /data/disk4/data
chown -R hadoop:hadoop /data/disk5/data
chown -R hadoop:hadoop /data/disk6/data
chown -R hadoop:hadoop /data/disk7/data
chown -R hadoop:hadoop /data/disk8/data
