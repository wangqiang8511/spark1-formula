{%- from 'spark1/settings.sls' import spark_env with context %}

stop_slave:
  file.managed:
    - name: {{ spark_env.spark_home }}/sbin/stop_local_slave.sh
    - template: jinja
    - source: salt://spark1/files/stop_local_slave.sh.template
    - mode: 755
    - user: spark
  cmd.run:
    - name: "{{ spark_env.spark_home }}/sbin/stop_local_slave.sh"
    - user: spark
    - require:
      - file: stop_slave
