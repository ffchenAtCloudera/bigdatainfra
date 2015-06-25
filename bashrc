export JAVA_HOME=/opt/jdk
export PATH=$PATH:$JAVA_HOME/bin

export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop/
export YARN_CONF_DIR=/opt/hadoop/etc/hadoop/
export HADOOP_PREFIX=/opt/hadoop
export HADOOP_YARN_HOME=/opt/hadoop/
export ZOOKEEPER_HOME=/opt/zookeeper
export ZOO_LOG_DIR=/opt/logs/zookeeper

export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$ZOOKEEPER_HOME/bin

export HBASE_HOME=/opt/hbase
export PATH=$PATH:$HBASE_HOME/bin
export HBASE_CONF_DIR=$HBASE_HOME/conf

export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin

export HIVE_HOME=/opt/hive
export PATH=$PATH:$HIVE_HOME/bin:$HIVE_HOME/hcatalog/sbin
export HADOOP_MAPRED_HOME=/opt/hadoop
