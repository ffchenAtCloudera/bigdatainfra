#Master node
mkdir -p /master/hadoop/dfs/name/current
chown -R hadoop:hadoop /master
mkdir -p /slave/hadoop/dfs/name/current
chown -R hadoop:hadoop /slave

#Agent node
mkdir -p /data01/data
mkdir -p /data02/data
chown -R hadoop:hadoop /data01
chown -R hadoop:hadoop /data02

#Zookeeper node
mkdir -p /home/zookeeper/data
chown -R hadoop:hadoop /home/zookeeper
echo 1 >> /home/zookeeper/data/myid
