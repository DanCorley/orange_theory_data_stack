FROM openjdk:19

ENV MB_PLUGINS_DIR=/plugins/
ENV MB_VERSION=v0.52.14.x

# https://github.com/motherduckdb/metabase_duckdb_driver
ADD https://downloads.metabase.com/$MB_VERSION/metabase.jar /home

CMD ["java", "-jar", "/home/metabase.jar"]
