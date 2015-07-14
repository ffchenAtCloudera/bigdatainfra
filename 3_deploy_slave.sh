#!/bin/bash
puppet=false

user=chenfangfang
passwd=newhadoop
home=/home/chenfangfang
cluster_home=/opt

backup_master=`cat conf/hadoop_backup_master.list`
./expect_scp ${backup_master} $user $passwd prepare_env.sh $home/
./expect_exec ${backup_master} $user $passwd "sudo $home/prepare_env.sh"
if [ $puppet = false ]; then
./expect_scp ${backup_master} $user $passwd slave_create_account.sh $home/
./expect_exec ${backup_master} $user $passwd "sudo $home/slave_create_account.sh"
fi
./expect_scp ${backup_master} $user $passwd /home/hadoop/.ssh/authorized_keys $home/
./expect_scp ${backup_master} $user $passwd /home/hadoop/.ssh/id_rsa $home/
./expect_scp ${backup_master} $user $passwd /home/hadoop/.ssh/id_rsa.pub $home/
./expect_exec ${backup_master} $user $passwd "sudo mv $home/authorized_keys /home/hadoop/.ssh/"
./expect_exec ${backup_master} $user $passwd "sudo mv $home/id_rsa /home/hadoop/.ssh/"
./expect_exec ${backup_master} $user $passwd "sudo mv $home/id_rsa.pub /home/hadoop/.ssh/"
./expect_exec ${backup_master} $user $passwd "sudo chown -R $user:$user /home/hadoop" 
./expect_scp ${backup_master} $user $passwd master_deploy_mkdir.sh $home/
./expect_exec ${backup_master} $user $passwd "sudo $home/master_deploy_mkdir.sh"
./expect_exec ${backup_master} $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_scp ${backup_master} $user $passwd $cluster_home/components/hadoop/ $cluster_home/hadoop/program
./expect_scp ${backup_master} $user $passwd $cluster_home/components/hbase/ $cluster_home/hbase/program
./expect_scp ${backup_master} $user $passwd $cluster_home/components/zookeeper/ $cluster_home/zookeeper/program
./expect_scp ${backup_master} $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_scp ${backup_master} $user $passwd /home/hadoop/.bashrc /home/hadoop/
./expect_exec ${backup_master} $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
./expect_exec ${backup_master} $user $passwd "sudo chown -R hadoop:hadoop /home/hadoop"

slave_lists=`cat conf/slave.list`
for ip in ${slave_lists}; do
./expect_scp $ip $user $passwd prepare_env.sh $home/
./expect_exec $ip $user $passwd "sudo $home/prepare_env.sh"
if [ $puppet = false ]; then
./expect_scp $ip $user $passwd slave_create_account.sh $home/
./expect_exec $ip $user $passwd "sudo $home/slave_create_account.sh"
fi
./expect_scp $ip $user $passwd /home/hadoop/.ssh/authorized_keys $home/
./expect_exec $ip $user $passwd "sudo mv $home/authorized_keys /home/hadoop/.ssh/"
./expect_scp $ip $user $passwd slave_deploy_mkdir.sh $home/
./expect_exec $ip $user $passwd "sudo $home/slave_deploy_mkdir.sh"
./expect_exec $ip $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_exec $ip $user $passwd "sudo chown -R $user:$user /home/hadoop/"
./expect_scp $ip $user $passwd $cluster_home/components/hadoop/ $cluster_home/hadoop/program
./expect_scp $ip $user $passwd $cluster_home/components/hbase/ $cluster_home/hbase/program
./expect_scp $ip $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_scp $ip $user $passwd /home/hadoop/.bashrc /home/hadoop/
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop /home/hadoop"
done

left_master_lists=`cat conf/left_masters.list`
for ip in ${left_master_lists}; do
./expect_scp $ip $user $passwd prepare_env.sh $home/
./expect_exec $ip $user $passwd "sudo $home/prepare_env.sh"
if [ $puppet = false ]; then
./expect_scp $ip $user $passwd slave_create_account.sh $home/
./expect_exec $ip $user $passwd "sudo $home/slave_create_account.sh"
fi
./expect_scp $ip $user $passwd master_deploy_mkdir.sh $home/
./expect_exec $ip $user $passwd "sudo $home/master_deploy_mkdir.sh"

./expect_scp $ip $user $passwd /home/hadoop/.ssh/authorized_keys $home/
./expect_scp $ip $user $passwd /home/hadoop/.ssh/id_rsa $home/
./expect_scp $ip $user $passwd /home/hadoop/.ssh/id_rsa.pub $home/

./expect_exec $ip $user $passwd "sudo mv $home/authorized_keys /home/hadoop/.ssh/"
./expect_exec $ip $user $passwd "sudo mv $home/id_rsa /home/hadoop/.ssh/"
./expect_exec $ip $user $passwd "sudo mv $home/id_rsa.pub /home/hadoop/.ssh/"
./expect_exec $ip $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_exec $ip $user $passwd "sudo chown -R $user:$user /home/hadoop/"
./expect_scp $ip $user $passwd $cluster_home/components/hadoop/ $cluster_home/hadoop/program
./expect_scp $ip $user $passwd $cluster_home/components/hbase/ $cluster_home/hbase/program
./expect_scp $ip $user $passwd $cluster_home/components/zookeeper/ $cluster_home/zookeeper/program
./expect_scp $ip $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_scp $ip $user $passwd /home/hadoop/.bashrc /home/hadoop/
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop /home/hadoop"
done

journal_nodes=`cat conf/jounalnode.list`
for ip in ${journal_nodes}; do
./expect_scp $ip $user $passwd journalnode_deploy_mkdir.sh $home/
./expect_exec $ip $user $passwd "sudo $home/journalnode_deploy_mkdir.sh"
done

zookeeper_nodes=`cat conf/zookeeper.list`
i=1
for zookeeper_node in ${zookeeper_nodes}; do
./expect_scp ${zookeeper_node} $user $passwd zookeeper_deploy_mkdir.sh $home/
./expect_exec ${zookeeper_node} $user $passwd "sudo $home/zookeeper_deploy_mkdir.sh $i"
i=`expr $i + 1`;
done

clients=`cat conf/clients.list`
for ip in $clients; do
./expect_exec $ip $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_exec $ip $user $passwd "sudo chown -R $user:$user /home/hadoop/"
./expect_scp $ip $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_scp $ip $user $passwd $cluster_home/components/hadoop/ $cluster_home/hadoop/program
./expect_scp $ip $user $passwd $cluster_home/components/hbase/ $cluster_home/hbase/program
./expect_scp $ip $user $passwd $cluster_home/components/hive/ $cluster_home/hive/program
./expect_scp $ip $user $passwd $cluster_home/components/kafka/ $cluster_home/kafka/program
./expect_scp $ip $user $passwd $cluster_home/components/spark/ $cluster_home/spark/program
./expect_scp $ip $user $passwd $cluster_home/components/zookeeper/ $cluster_home/zookeeper/program
./expect_scp $ip $user $passwd /home/hadoop/.bashrc /home/hadoop/
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop /home/hadoop"
done


hbase_clients=`cat conf/hbase.list`
for ip in ${hbase_clients}; do
./expect_scp $ip $user $passwd prepare_env.sh $home/
./expect_exec $ip $user $passwd "sudo $home/prepare_env.sh"
if [ $puppet = false ]; then
./expect_scp $ip $user $passwd slave_create_account.sh $home/
./expect_exec $ip $user $passwd "sudo $home/slave_create_account.sh"
fi
./expect_scp $ip $user $passwd clients_deploy_mkdir.sh $home/
./expect_exec $ip $user $passwd "sudo $home/clients_deploy_mkdir.sh"

./expect_exec $ip $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_scp $ip $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_scp $ip $user $passwd $cluster_home/components/hbase/ $cluster_home/hbase/program
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
./expect_exec $ip $user $passwd "sudo chown -R hadoop:hadoop /home/hadoop"
done

hive_clients=`cat conf/hive.list`
for hive_node in ${hive_clients}; do
./expect_scp ${hive_node} $user $passwd prepare_env.sh $home/
./expect_exec $ip $user $passwd "sudo $home/prepare_env.sh"
if [ $puppet = false ]; then
./expect_scp ${hive_node} $user $passwd slave_create_account.sh $home/
./expect_exec ${hive_node} $user $passwd "sudo $home/slave_create_account.sh"
fi
./expect_scp ${hive_node} $user $passwd clients_deploy_mkdir.sh $home/
./expect_exec ${hive_node} $user $passwd "sudo $home/clients_deploy_mkdir.sh"

./expect_exec ${hive_node} $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_scp ${hive_node} $user $passwd $cluster_home/components/hive/ $cluster_home/hive/program
./expect_scp ${hive_node} $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_exec ${hive_node} $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
done

kafka_clients=`cat conf/kafka.list`
for kafka_node in ${kafka_clients}; do
./expect_scp ${kafka_node} $user $passwd prepare_env.sh $home/
./expect_exec ${kafka_node} $user $passwd "sudo $home/prepare_env.sh"
if [ $puppet = false ]; then
./expect_scp ${kafka_node} $user $passwd slave_create_account.sh $home/
./expect_exec ${kafka_node} $user $passwd "sudo $home/slave_create_account.sh"
fi
./expect_scp ${kafka_node} $user $passwd clients_deploy_mkdir.sh $home/
./expect_exec ${kafka_node} $user $passwd "sudo $home/clients_deploy_mkdir.sh"
./expect_exec ${kafka_node} $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_scp ${kafka_node} $user $passwd $cluster_home/components/kafka/ $cluster_home/kafka/program
./expect_scp ${kafka_node} $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_exec ${kafka_node} $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
done

spark_clients=`cat conf/spark.list`
for spark_node in ${spark_clients}; do
./expect_scp ${spark_node} $user $passwd prepare_env.sh $home/
./expect_exec ${spark_node} $user $passwd "sudo $home/prepare_env.sh"
if [ $puppet = false ]; then
./expect_scp ${spark_node} $user $passwd slave_create_account.sh $home/
./expect_exec ${spark_node} $user $passwd "sudo $home/slave_create_account.sh"
fi
./expect_exec ${spark_node} $user $passwd "sudo chown -R $user:$user $cluster_home"
./expect_scp ${spark_node} $user $passwd $cluster_home/components/spark/ $cluster_home/spark/program
./expect_scp ${spark_node} $user $passwd $cluster_home/components/jdk $cluster_home/
./expect_exec ${spark_node} $user $passwd "sudo chown -R hadoop:hadoop $cluster_home"
done
