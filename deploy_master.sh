yum -y install rsync
yum -y install openssh-clients
yum -y install expect

./mkdir.sh
mkdir -p ~/bigdatainfra_deploy/package
cd ~/bigdatainfra_deploy/package
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/hadoop/hadoop-dist/2.6.0-cdh5.4.1/hadoop-dist-2.6.0-cdh5.4.1.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/zookeeper/zookeeper-dist/3.4.5-cdh5.4.1/zookeeper-dist-3.4.5-cdh5.4.1.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/org/apache/hbase/hbase-dist/1.0.0-cdh5.4.1-bin/hbase-dist-1.0.0-cdh5.4.1-bin.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/zoo.cfg
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/tools/jdk-7u75-linux-x64.tar.gz
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/core-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hadoop-env.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hdfs-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/mapred-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/slaves
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/yarn-env.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/yarn-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hbase-site.xml
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/hbase-env.sh
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/regionservers
wget http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS/configuration_files/backup-masters

tar zxf jdk-7u75-linux-x64.tar.gz -C /opt/
tar zxf zookeeper-dist-3.4.5-cdh5.4.1.tar.gz -C /opt/
tar zxf hadoop-dist-2.6.0-cdh5.4.1.tar.gz -C /opt/
tar zxf hbase-dist-1.0.0-cdh5.4.1-bin.tar.gz -C /opt/
mv /opt/hadoop* /opt/hadoop
mv /opt/zookeeper* /opt/zookeeper
mv /opt/hbase* /opt/hbase

#Update configuration files
yes|cp core-site.xml hadoop-env.sh hdfs-site.xml mapred-site.xml slaves yarn-env.sh yarn-site.xml /opt/hadoop/etc/hadoop/
yes|cp hbase-site.xml hbase-env.sh regionservers backup-masters /opt/hbase/conf/
yes|cp zoo.cfg /opt/zookeeper/conf/

groupadd hadoop
useradd hadoop -g hadoop -p hadoop
sudo chown -R hadoop:hadoop /opt


su hadoop
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cd ~/.ssh/
cp id_rsa.pub authorized_keys

