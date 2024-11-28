FROM openjdk:19

ENV MB_PLUGINS_DIR=/plugins/
ENV MB_VERSION=v0.51.3

ADD https://downloads.metabase.com/$MB_VERSION/metabase.jar /home

CMD ["java", "-jar", "/home/metabase.jar"]
