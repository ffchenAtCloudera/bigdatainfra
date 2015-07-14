#!/bin/bash

dir=`pwd`
repo_url=http://10.20.69.85:8081/nexus/content/repositories/BigDataInfra_OS
configuration_files_url=$repo_url/configuration_files
bin_url=$repo_url/bin
package_dir=~/bigdatainfra_deploy/package
cluster_home=/opt
puppet=false


#prepare dev env
yum -y install rsync
yum -y install openssh-clients
yum -y install expect
yum -y install lrzsz
yum -y install telnet

#download packages and configuration files
mkdir -p $package_dir
cd $package_dir
conf_files=`cat $dir/conf/conf_files.list`
for file in ${conf_files}; do
wget $configuration_files_url/$file
done

bin_files=`cat $dir/conf/bin_files.list`
for file in ${bin_files}; do
wget $bin_url/$file
done

wget $repo_url/org/apache/hadoop/hadoop-dist/2.6.0-cdh5.4.1/hadoop-dist-2.6.0-cdh5.4.1.tar.gz
wget $repo_url/org/apache/zookeeper/zookeeper-dist/3.4.5-cdh5.4.1/zookeeper-dist-3.4.5-cdh5.4.1.tar.gz
wget $repo_url/org/apache/hbase/hbase-dist/1.0.0-cdh5.4.1-bin/hbase-dist-1.0.0-cdh5.4.1-bin.tar.gz
wget $repo_url/org/apache/spark/spark-dist/1.3.0-cdh5.4.1/spark-dist-1.3.0-cdh5.4.1.tgz
wget $repo_url/org/apache/kafka/kafka-dist/0.8.2.0-kafka-1.3.0/kafka-dist-0.8.2.0-kafka-1.3.0.tgz
wget $repo_url/org/apache/hive/hive-packaging/1.1.0-cdh5.4.1/hive-packaging-1.1.0-cdh5.4.1-bin.tar.gz
wget $repo_url/tools/jdk-7u75-linux-x64.tar.gz


#master components home
mkdir -p $cluster_home/components
cp -r $dir/conf $cluster_home/components/
tar zxf jdk-7u75-linux-x64.tar.gz -C $cluster_home/components/
tar zxf zookeeper-dist-3.4.5-cdh5.4.1.tar.gz -C $cluster_home/components/
tar zxf hadoop-dist-2.6.0-cdh5.4.1.tar.gz -C $cluster_home/components/
tar zxf hbase-dist-1.0.0-cdh5.4.1-bin.tar.gz -C $cluster_home/components/
tar zxf spark-dist-1.3.0-cdh5.4.1.tgz -C $cluster_home/components/
tar zxf kafka-dist-0.8.2.0-kafka-1.3.0.tgz -C $cluster_home/components/
tar zxf hive-packaging-1.1.0-cdh5.4.1-bin.tar.gz -C $cluster_home/components/
cd $cluster_home/components/
ln -s *hive* hive
ln -s hadoop* hadoop
ln -s zookeeper* zookeeper
ln -s hbase* hbase
ln -s spark* spark
ln -s kafka* kafka
ln -s jdk* jdk

cd $dir
if [ $puppet = false ]; then
#create user and passwdless for ssh localhost
userdel hadoop
userdel hbase
groupdel hadoop
groupadd -g 1001 hadoop
useradd hadoop -u 1001 -g hadoop
fi

rm -rf /home/hadoop/.ssh
su hadoop -l -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa"
su hadoop -l -c "cp /home/hadoop/.ssh/id_rsa.pub /home/hadoop/.ssh/authorized_keys"

#environment variables setup
cat /home/hadoop/.bashrc bashrc >> /home/hadoop/.bashrc

sudo chown -R hadoop:hadoop $cluster_home
sudo chown -R hadoop:hadoop /home/hadoop
#mkdir for cluster deploy
mkdir -p /opt/components/utils/hadoop
mkdir -p /opt/components/utils/hive
mkdir -p /opt/components/utils/hbase
mkdir -p /opt/components/utils/zookeeper
mkdir -p /opt/components/utils/spark
mkdir -p /opt/components/utils/kafka
mkdir -p /opt/components/utils/cluster
./master_deploy_mkdir.sh
