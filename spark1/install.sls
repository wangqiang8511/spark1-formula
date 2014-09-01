{%- from 'spark1/settings.sls' import spark_env with context %}
{%- from 'spark1/settings.sls' import spark with context %}

spark_user:
  user.present:
    - name: spark
    - fullname: Spark User
    - shell: /bin/bash
    - groups:
      - wheel

spark_dir:
  file.directory:
    - name: {{ spark_env.spark_home }}
    - user: spark
    - group: spark
    - mode: 755 
    - makedirs: True
    - require:
      - user: spark_user

install_spark:
  archive.extracted:
    - name: /tmp/spark
    - source: {{ spark.source_prefix }}/{{ spark.version }}/{{ spark.version }}-bin-hadoop{{ spark.hadoop_version }}.tgz
    - source_hash: {{ spark.source_prefix }}/{{ spark.version }}-bin-hadoop{{ spark.hadoop_version }}.tgz.md5
    - if_missing: /tmp/spark/{{ spark.version }}-bin-hadoop{{ spark.hadoop_version }}
    - archive_format: tar
    - tar_options: z
    - require:
      - user: spark_user
  cmd.wait:
    - name: "chown -R spark:spark /tmp/spark" 
    - watch:
      - archive: install_spark

mv_spark_folder:
  cmd.wait:
    - name: "mv /tmp/spark/{{ spark.version }}-bin-hadoop{{ spark.hadoop_version}}/* {{ spark_env.spark_home }}" 
    - user: spark 
    - watch:
      - cmd: install_spark
    - require: 
      - cmd: install_spark
      - file: spark_dir
