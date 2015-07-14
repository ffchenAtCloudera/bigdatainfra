export JAVA_HOME=/opt/jdk
export PATH=$JAVA_HOME/bin:$PATH

export HADOOP_HOME=/opt/hadoop/program
export HADOOP_CONF_DIR=/opt/hadoop/program/etc/hadoop
export HADOOP_PID_DIR=/opt/hadoop/pids
export YARN_CONF_DIR=/opt/hadoop/program/etc/hadoop
export HADOOP_PREFIX=/opt/hadoop/program
export HADOOP_YARN_HOME=/opt/hadoop/program
export HADOOP_MAPRED_PID_DIR=/opt/hadoop/pids

export ZOOKEEPER_HOME=/opt/zookeeper/program
export ZOO_LOG_DIR=/opt/logs/zookeeper

export PATH=$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$ZOOKEEPER_HOME/bin:$PATH

export HBASE_HOME=/opt/hbase/program
export PATH=$HBASE_HOME/bin:$PATH
export HBASE_CONF_DIR=$HBASE_HOME/conf
export HBASE_PID_DIR=/opt/hbase/pids

export SPARK_HOME=/opt/spark/program
export PATH=$SPARK_HOME/bin:$PATH
export SPARK_PID_DIR=/opt/spark/pids

export HIVE_HOME=/opt/hive/program
export PATH=$HIVE_HOME/bin:$HIVE_HOME/hcatalog/sbin:$PATH
export HADOOP_MAPRED_HOME=/opt/hadoop/program
