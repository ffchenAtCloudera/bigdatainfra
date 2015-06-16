#!/bin/bash


ip_lists=`cat ip.list`
for ip in ${ip_lists}; do
./expect_scp $ip root P@ssw0rd slave_create_account.sh /root/
./expect_exec $ip root P@ssw0rd /root/slave_create_account.sh
./expect_scp $ip root P@ssw0rd /home/hadoop/.ssh/authorized_keys /home/hadoop/.ssh/
./expect_exec $ip root P@ssw0rd "chown -R hadoop:hadoop /home/hadoop/.ssh" 
./expect_scp $ip root P@ssw0rd mkdir.sh /root
./expect_exec $ip root P@ssw0rd /root/mkdir.sh
su hadoop
./expect_exec $ip hadoop "" /opt/* /opt/
./expect_exec $ip hadoop "" /home/hadoop/.bashrc /home/hadoop/
done

