#!/bin/bash

#Zookeeper node
mkdir -p /home/zookeeper/data
chown -R hadoop:hadoop /home/zookeeper
echo "$@" >> /home/zookeeper/data/myid
