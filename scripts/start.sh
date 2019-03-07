#!/bin/bash

RUNTIME_ENVIRONMENT=$1
AWS_ACCOUNT_ID=$2
AWS_REGION=$3
BUILD_VERSION=$4
INSTANCE_ID=$HOSTNAME
WORKING_DIR=/opt/apps/stock-service

memk=`cat /proc/meminfo | grep '^MemTotal: .* kB$' | awk '{print $2}'`
[[ -z "$memk" ]] && fatal 'Unable to query /proc/meminfo for MemTotal'
memm=$((memk / 1024 * 60 / 100 ))
JVM_MEM="${memm}M"
((memm < 1024)) && fatal "Not enough memory to run our application! ($JVM_MEM)"
echo "JVM_MEM=$JVM_MEM"

export JAVA_HOME=/usr/lib/jvm

export RUNTIME=$RUNTIME_ENVIRONMENT
export BUILD_VERSION=$BUILD_VERSION

JVM_ARGS="-Xmx${JVM_MEM} -XX:+PrintGCDateStamps -verbose:gc -Xloggc:/opt/apps/data-lake/service-gc.log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${WORKING_DIR} -Dcom.sun.management.jmxremote.port=8855 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

java ${JVM_ARGS} -DRUNTIME_ENVIRONMENT=${RUNTIME_ENVIRONMENT} -DACCOUNT_ID=${AWS_ACCOUNT_ID} -DAWS_REGION=${AWS_REGION} -jar $WORKING_DIR/gs-rest-service.jar
