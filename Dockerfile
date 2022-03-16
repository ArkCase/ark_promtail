FROM 345280441424.dkr.ecr.ap-south-1.amazonaws.com/ark_base:latest

RUN yum update -y
RUN yum install -y unzip
LABEL ORG="ArkCase LLC" \
      APP="Promtail" \
      VERSION="1.0" \
      IMAGE_SOURCE="https://github.com/ArkCase/ark_Promtail" \
      MAINTAINER="ArkCase LLC"

#Promtail
ARG PROMTAIL_VERSION="2.4.2"

ENV PROMTAIL_USERID=2000 \
    PROMTAIL_GROUPID=2020 \
    PROMTAIL_GROUPNAME=promtail \
    PROMTAIL_USER=promtail \
    PROMTAIL_URL="https://github.com/grafana/loki/releases/download/v${PROMTAIL_VERSION}/promtail-linux-amd64.zip"
RUN groupadd -g ${PROMTAIL_GROUPID} ${PROMTAIL_GROUPNAME} && \
    useradd -u ${PROMTAIL_USERID} -g ${PROMTAIL_GROUPNAME} ${PROMTAIL_USER}
WORKDIR /opt
ADD ${PROMTAIL_URL} /opt

RUN set -ex;\
    unzip promtail-linux-amd64.zip;\
    rm /opt/promtail-linux-amd64.zip; \
    chown -R ${PROMTAIL_USER}:${PROMTAIL_USER} /opt;\
    chown -R ${PROMTAIL_USER}:${PROMTAIL_USER} /var/log;\
    ln -s $(pwd)/promtail-linux-amd64 /usr/local/bin/promtail
COPY promtail-config.yaml .

CMD ["promtail", "-config.file=/opt/promtail-config.yaml"]