{% set pspark  = salt['pillar.get']('spark', {}) %}
{% set gspark  = salt['grains.get']('spark', {}) %}

{% set psparkenv  = salt['pillar.get']('spark_env', {}) %}
{% set gsparkenv  = salt['grains.get']('spark_env', {}) %}

{% set spark_slaves = salt['grains.get']('spark_slaves', [])%}


{%- set default_java_home = '/opt/java/default' %}
{%- set default_spark_home = '/opt/spark' %}
{%- set default_spark_master_ip = '192.168.0.1' %}
{%- set default_spark_master_port = '7070' %}
{%- set default_spark_worker_cores = '2' %}
{%- set default_spark_worker_memory = '500m' %}
{%- set default_spark_worker_port = '9090' %}
{%- set default_spark_worker_instances = '1' %}
{%- set default_spark_local_dir = '/tmp/spark/' %}

{%- set java_home   = gsparkenv.get('java_home', psparkenv.get('java_home', default_java_home)) %}
{%- set spark_home   = gsparkenv.get('spark_home', psparkenv.get('spark_home', default_spark_home)) %}
{%- set spark_master_ip   = gsparkenv.get('spark_master_ip', psparkenv.get('spark_master_ip', default_spark_master_ip)) %}
{%- set spark_master_port   = gsparkenv.get('spark_master_port', psparkenv.get('spark_master_port', default_spark_master_port)) %}
{%- set spark_worker_cores = gsparkenv.get('spark_worker_cores', psparkenv.get('spark_worker_cores', default_spark_worker_cores)) %}
{%- set spark_worker_memory = gsparkenv.get('spark_worker_memory', psparkenv.get('spark_worker_memory', default_spark_worker_memory)) %}
{%- set spark_worker_port = gsparkenv.get('spark_worker_port', psparkenv.get('spark_worker_port', default_spark_worker_port)) %}
{%- set spark_worker_instances = gsparkenv.get('spark_worker_instances', psparkenv.get('spark_worker_instances', default_spark_worker_instances)) %}
{%- set spark_local_dir = gsparkenv.get('spark_local_dir', psparkenv.get('spark_local_dir', default_spark_local_dir)) %}

{%- set spark_env= {} %}
{%- do spark_env.update({ 
    'java_home'   : java_home,
    'spark_home'  : spark_home,
    'spark_master_ip' : spark_master_ip,
    'spark_master_port' : spark_master_port,
    'spark_worker_cores' : spark_worker_cores,
    'spark_worker_memory' : spark_worker_memory,
    'spark_worker_port' : spark_worker_port,
    'spark_worker_instances' : spark_worker_instances,
    'spark_local_dir' : spark_local_dir
}) %}

{%- set default_spark_version = 'spark-1.0.2' %}
{%- set default_hadoop_version = '2' %}
{%- set default_use_yarn = '' %}
{%- set default_source_prefix = 'https://archive.apache.org/dist/spark/' %}

{%- set spark_version = gspark.get('version', pspark.get('version', default_spark_version)) %}
{%- set spark_hadoop_version = gspark.get('hadoop_version', pspark.get('hadoop_version', default_hadoop_version)) %}
{%- set spark_use_yarn = gspark.get('use_yarn', pspark.get('use_yarn', default_use_yarn)) %}
{%- set spark_source_prefix = gspark.get('source_prefix', pspark.get('source_prefix', default_source_prefix)) %}

{%- set spark = {} %}
{%- do spark.update( { 
    'version'   : spark_version,
    'hadoop_version'  : spark_hadoop_version,
    'source_prefix'  : spark_source_prefix,
    'use_yarn'  : spark_use_yarn,
}) %}
