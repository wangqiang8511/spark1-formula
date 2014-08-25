{%- from 'spark1/settings.sls' import spark_env with context %}

stop_env:
    cmd.run:
    - name: "{{ spark_env.spark_home }}/sbin/stop-master.sh"
    - user: spark
