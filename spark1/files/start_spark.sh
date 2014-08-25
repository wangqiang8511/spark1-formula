#!/bin/bash
#
{%- from 'spark1/settings.sls' import spark_env with context %}

echo "Checking Master..."

{{ spark_env.spark_home }}/sbin/start-master.sh

nc -z {{ spark_env.spark_master_ip }} 7070 
while [ $? -eq 1 ] 
do
sleep 1
nc -z {{ spark_env.spark_master_ip }} 7070 
done

echo "Checking Slaves..."
{{ spark_env.spark_home }}/sbin/start-slaves.sh
