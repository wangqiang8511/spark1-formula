{%- from 'spark1/settings.sls' import spark_env with context %}

start_slave:
  file.managed:
    - name: {{ spark_env.spark_home }}/sbin/start_local_slave.sh
    - template: jinja
    - source: salt://spark1/files/start_local_slave.sh.template
    - mode: 755
    - user: spark
  cmd.run:
    - name: "{{ spark_env.spark_home }}/sbin/start_local_slave.sh"
    - user: spark
    - reqruie: 
      file: start_slave
