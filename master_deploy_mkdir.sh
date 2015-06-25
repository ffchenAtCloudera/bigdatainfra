#log
mkdir -p /opt/logs/hadoop
mkdir -p /opt/logs/yarn
mkdir -p /opt/logs/hbase
mkdir -p /opt/logs/zookeeper
mkdir -p /opt/logs/spark
mkdir -p /opt/logs/hive
mkdir -p /opt/logs/kafka/server

chown -R hadoop:hadoop /opt

#Hadoop Master node
mkdir -p /namenode/hadoop/dfs/name/
chown -R hadoop:hadoop /namenode
mkdir -p /namenode_repli/hadoop/dfs/name/
chown -R hadoop:hadoop /namenode_repli
