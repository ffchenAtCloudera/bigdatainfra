#log
mkdir -p /opt/logs/hadoop
mkdir -p /opt/logs/yarn
mkdir -p /opt/logs/hbase
mkdir -p /opt/logs/zookeeper
mkdir -p /opt/logs/spark
mkdir -p /opt/logs/hive
mkdir -p /opt/logs/kafka
mkdir -p /opt/hadoop/pids
mkdir -p /opt/hbase/pids
mkdir -p /opt/zookeeper/pids


chown -R hadoop:hadoop /opt

#Hadoop Master node
mkdir -p /data/namenode/dfs/name/
chown -R hadoop:hadoop /data/namenode
mkdir -p /data/namenode_repli/dfs/name/
chown -R hadoop:hadoop /data/namenode_repli
