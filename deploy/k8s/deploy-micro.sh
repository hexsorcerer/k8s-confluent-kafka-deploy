#!/bin/bash

function clean_up() {
    rm -rf cp-helm-charts
}

export GIT_REDIRECT_STDERR=2>&1
export GIT_REDIRECT_STDOUT=1>/dev/null
git clone https://github.com/confluentinc/cp-helm-charts.git
printf "Cloned cp-helm-charts repo successfully\n"

sed -i \
    's/apiVersion\: policy\/v1beta1/apiVersion\: policy\/v1/g' \
    ./cp-helm-charts/charts/cp-zookeeper/templates/poddisruptionbudget.yaml
printf "Applied fix to cp-zookeeper poddisruptionbudget template\n"

helm install \
    --set cp-control-center.enabled=false \
    --set cp-kafka-connect.enabled=false \
    --set cp-kafka-rest.enabled=false \
    --set cp-ksql-server.enabled=false \
    --set cp-schema-registry.enabled=false \
    --set cp-zookeeper.servers=1 \
    --set cp-kafka.image=confluentinc/cp-kafka \
    --set cp-kafka.configurationOverrides.offsets.topic.replication.factor=1 \
    --set cp-kafka.brokers=1 \
    --set cp-kafka.customEnv.KAFKA_METRIC_REPORTERS= \
    --set cp-zookeeper.prometheus.jmx.enabled=false \
    --set cp-kafka.prometheus.jmx.enabled=false \
    kafka \
    ./cp-helm-charts \
    2>&1 1>/dev/null

if [[ $? == 0 ]]; then
    printf "Installed cp-helm-charts successfully\n"
else
    printf "An error occurred while installing cp-helm-charts\n"
fi

clean_up

printf "Cleaned up successfully\n"