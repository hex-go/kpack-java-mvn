#!/bin/sh

export SERVER_HOME=$(cd `dirname $0`; pwd)

#
# service discovery
#
if [ -z "$DISCOVERY_USED" ]; then
	export QLOUD_DISCOVERY_USED="true"
else
	export QLOUD_DISCOVERY_USED="$DISCOVERY_USED"
fi

#
# service discovery schema
#
if [ -z "$DISCOVERY_SSL" ]; then
	export QLOUD_SSL_USED="false"
else
	export QLOUD_SSL_USED="$DISCOVERY_SSL"
fi

#
# service discovery name
#
if [ -z "$DISCOVERY_NAME" ]; then
	export QLOUD_DISCOVERY_NAME="dap.service.kernel"
else
	export QLOUD_DISCOVERY_NAME="$DISCOVERY_NAME"
fi

#
# public service ingress address
#
if [ -z "$DISCOVERY_INGRESS" ]; then
	export QLOUD_DISCOVERY_PUBLIC_HOST="qloudkernel.service.sd"
else
	export QLOUD_DISCOVERY_PUBLIC_HOST="$DISCOVERY_INGRESS"
fi

if [ -z "$DISCOVERY_INGRESS_PORT" ]; then
	export QLOUD_DISCOVERY_PUBLIC_PORT="80"
else
	export QLOUD_DISCOVERY_PUBLIC_PORT="$DISCOVERY_INGRESS_PORT"
fi

#
# local cluster address with namespace
#
if [ -z "$DISCOVERY_CLUSTER" ]; then
	export QLOUD_DISCOVERY_LOCAL_HOST="qloudkernel"
else
	export QLOUD_DISCOVERY_LOCAL_HOST="$DISCOVERY_CLUSTER"
fi

if [ -z "$DISCOVERY_CLUSTER_PORT" ]; then
	export QLOUD_DISCOVERY_LOCAL_PORT="8888"
else
	export QLOUD_DISCOVERY_LOCAL_PORT="$DISCOVERY_CLUSTER_PORT"
fi

#
# service consul
#
###################
if [ -z "$CONSUL_AGENT" ]; then
	export QLOUD_CONSUL_HOST="127.0.0.1"
else
	export QLOUD_CONSUL_HOST="$CONSUL_AGENT"
fi

if [ -z "$CONSUL_AGENT_SCHEMA" ]; then
	export QLOUD_CONSUL_SCHEMA="http"
else
	export QLOUD_CONSUL_SCHEMA="$CONSUL_AGENT_SCHEMA"
fi

if [ -z "$CONSUL_AGENT_PORT" ]; then
	export QLOUD_CONSUL_PORT="8500"
else
	export QLOUD_CONSUL_PORT="$CONSUL_AGENT_PORT"
fi

if [ -z "$CONSUL_AGENT_DC" ]; then
	export QLOUD_CONSUL_DC="dc1"
else
	export QLOUD_CONSUL_DC="$CONSUL_AGENT_DC"
fi

if [ -z "$CONSUL_AGENT_TAG" ]; then
	export QLOUD_CONSUL_TAG="qloudservice"
else
	export QLOUD_CONSUL_TAG="$CONSUL_AGENT_TAG"
fi

export QLOUD_CONSUL_TOKEN="$CONSUL_AGENT_TOKEN"
export QLOUD_CONSUL_ID="$SERVICE_INSTANCE"
export QLOUD_CONSUL_SUFFIX="$SERVICE_SUFFIX"

if [ -z "$SERVICE_REGISTERED" ]; then
	export QLOUD_CONSUL_REGISTERED="false"
else
	export QLOUD_CONSUL_REGISTERED="$SERVICE_REGISTERED"
fi

if [ -z "$SERVICE_CHECKED" ]; then
	export QLOUD_CONSUL_CHECKED="false"
else
	export QLOUD_CONSUL_CHECKED="$SERVICE_CHECKED"
fi

###################

#
# service configuration
#
if [ -z "$CONFIG_USED" ]; then
	export QLOUD_CONFIG_USED="true"
else
	export QLOUD_CONFIG_USED="$CONFIG_USED"
fi

if [ -z "$CONFIG_NAMESPACE" ]; then
	export QLOUD_CONFIG_NAMESPACE="default"
else
	export QLOUD_CONFIG_NAMESPACE="$CONFIG_NAMESPACE"
fi

if [ -z "$CONFIG_ENVIROMENT" ]; then
	export QLOUD_CONFIG_ENVIROMENT="default"
else
	export QLOUD_CONFIG_ENVIROMENT="$CONFIG_ENVIROMENT"
fi

if [ -z "$CONFIG_TOPIC" ]; then
	export QLOUD_CONFIG_TOPIC="Qloudbus.Configuration"
else
	export QLOUD_CONFIG_TOPIC="$CONFIG_TOPIC"
fi

#
# service jvm
#
if [ -z "$SERVER_OPTS" ]; then
	# == jadk8
	#export JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
	# >= jdk10
	export JAVA_OPTS="--add-opens java.base/jdk.internal.misc=ALL-UNNAMED -Dio.netty.tryReflectionSetAccessible=true -XX:MinRAMPercentage=90 -XX:MaxRAMPercentage=90"
else
	export JAVA_OPTS="$SERVER_OPTS"
fi

#
# service namespace
#
#if [ -z "$SERVICE_NAMESPACE" ]; then
#	export QLOUD_DEPLOYED_NAMESPACE=""
#else
#	export QLOUD_DEPLOYED_NAMESPACE=".$SERVICE_NAMESPACE"
#fi

#
# service token
#
if [ -z "$SERVICE_TOKEN" ]; then
	export QLOUD_SERVICE_TOKEN=""
else
	export QLOUD_SERVICE_TOKEN="$SERVICE_TOKEN"
fi

#
# service name
#
if [ -z "$SERVICE_NAME" ]; then
	export QLOUD_SERVICE_NAME=$(echo $1)
else
	if [ "$SERVICE_NAME" != "" ]; then
		export QLOUD_SERVICE_NAME="$SERVICE_NAME.conf"
	else
		export QLOUD_SERVICE_NAME=$(echo $1)
	fi
fi
echo $QLOUD_SERVICE_NAME > /usr/share/filebeat/service-log.conf

#
# service config full name
#
#QLOUD_AGENT_NAME=$(echo $QLOUD_SERVICE_NAME | sed "s/\.conf/$QLOUD_DEPLOYED_NAMESPACE.conf/g")

#
# run agent service
#
$JAVA_HOME/bin/java -Xms512M -Xmx512M -Dlog4j.configurationFile="$SERVER_HOME/agent.xml" -cp "$SERVER_HOME:$SERVER_HOME/classes:$SERVER_HOME/lib/*:$SERVER_HOME/*:$SERVER_HOME/extra/*" com.icos.icosbus.sdk.agent.IcosServiceAgent $QLOUD_SERVICE_NAME
