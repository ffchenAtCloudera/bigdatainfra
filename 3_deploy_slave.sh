#!/bin/bash

user=root
passwd=P@ssw0rd

backup_master=`cat conf/backup_master.list`
./expect_scp ${backup_master} $user $passwd slave_create_account.sh /root/
./expect_exec ${backup_master} $user $passwd /root/slave_create_account.sh
./expect_scp ${backup_master} $user $passwd /home/hadoop/.ssh/authorized_keys /home/hadoop/.ssh/
./expect_exec ${backup_master} $user $passwd "cat /home/hadoop/.ssh/id_rsa.pub /home/hadoop/.ssh/authorized_keys >> /home/hadoop/.ssh/authorized_keys"
./expect_scpToLocal ${backup_master} $user $passwd /home/hadoop/.ssh/authorized_keys /home/hadoop/.ssh/
./expect_exec ${backup_master} $user $passwd "chown -R hadoop:hadoop /home/hadoop/.ssh"
./expect_scp ${backup_master} $user $passwd master_deploy_mkdir.sh /root
./expect_exec ${backup_master} $user $passwd /root/master_deploy_mkdir.sh
./expect_scp ${backup_master} $user $passwd /opt/components/hadoop /opt/
./expect_scp ${backup_master} $user $passwd /opt/components/jdk /opt/
./expect_exec ${backup_master} $user $passwd "chown -R hadoop:hadoop /opt"
./expect_scp ${backup_master} $user $passwd /home/hadoop/.bashrc /home/hadoop/
./expect_exec ${backup_master} $user $passwd "chown -R hadoop:hadoop /opt"
./expect_exec ${backup_master} $user $passwd "chown -R hadoop:hadoop /home/hadoop"

slave_lists=`cat conf/slave.list`
for ip in ${slave_lists}; do
./expect_scp $ip $user $passwd slave_create_account.sh /root/
./expect_exec $ip $user $passwd /root/slave_create_account.sh
./expect_scp $ip $user $passwd /home/hadoop/.ssh/authorized_keys /home/hadoop/.ssh/
./expect_exec $ip $user $passwd "chown -R hadoop:hadoop /home/hadoop/.ssh" 
./expect_scp $ip $user $passwd slave_deploy_mkdir.sh /root
./expect_exec $ip $user $passwd /root/slave_deploy_mkdir.sh
./expect_scp $ip $user $passwd /opt/components/hadoop /opt/
./expect_scp $ip $user $passwd /opt/components/jdk /opt/
./expect_scp $ip $user $passwd /home/hadoop/.bashrc /home/hadoop/
./expect_exec $ip $user $passwd "chown -R hadoop:hadoop /opt"
./expect_exec $ip $user $passwd "chown -R hadoop:hadoop /home/hadoop"
done

journal_nodes=`cat conf/jounalnode.list`
for journal_node in ${journal_nodes}; do
./expect_scp ${journal_node} $user $passwd journalnode_deploy_mkdir.sh /root
./expect_exec ${journal_node} $user $passwd /root/journalnode_deploy_mkdir.sh
done

hbase_nodes=`cat conf/hbase.list`
for hbase_node in ${hbase_nodes}; do
./expect_scp ${hbase_node} $user $passwd /opt/components/hbase /opt/
./expect_exec ${hbase_node} $user $passwd "chown -R hadoop:hadoop /opt"
done

zookeeper_nodes=`cat conf/zookeeper.list`
i=1
for zookeeper_node in ${zookeeper_nodes}; do
./expect_scp ${zookeeper_node} $user $passwd zookeeper_deploy_mkdir.sh /root
./expect_exec ${zookeeper_node} $user $passwd "/root/zookeeper_deploy_mkdir.sh $i"
i=`expr $i + 1`;
./expect_scp ${zookeeper_node} $user $passwd /opt/components/zookeeper /opt/
./expect_exec ${zookeeper_node} $user $passwd "chown -R hadoop:hadoop /opt"
done

hive_nodes=`cat conf/hive.list`
for hive_node in ${hive_nodes}; do
./expect_scp ${hive_node} $user $passwd /opt/components/hive /opt/
./expect_exec ${hive_node} $user $passwd "chown -R hadoop:hadoop /opt"
done

kafka_nodes=`cat conf/kafka.list`
for kafka_node in ${kafka_nodes}; do
./expect_scp ${kafka_node} $user $passwd /opt/components/kafka /opt/
./expect_exec ${kafka_node} $user $passwd "chown -R hadoop:hadoop /opt"
done

spark_nodes=`cat conf/spark.list`
for spark_node in ${spark_nodes}; do
./expect_scp ${spark_node} $user $passwd /opt/components/spark /opt/
./expect_exec ${spark_node} $user $passwd "chown -R hadoop:hadoop /opt"
done
