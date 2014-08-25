{%- from 'spark1/settings.sls' import spark_env with context %}

config_spark_env:
  file.managed:
    - name: {{ spark_env.spark_home }}/conf/spark-env.sh
    - template: jinja
    - source: salt://spark1/files/spark-env.sh.template
    - mode: 644

config_spark_slave:
  file.managed:
    - name: {{ spark_env.spark_home }}/conf/slaves
    - template: jinja
    - source: salt://spark1/files/slaves
    - mode: 644

config_hive:
  file.managed:
    - name: {{ spark_env.spark_home }}/conf/hive-site.xml
    - template: jinja
    - source: salt://spark1/files/hive-site.xml
    - mode: 644

