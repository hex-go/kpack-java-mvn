#!/bin/sh

export SERVER_HOME=$(cd `dirname $0`; pwd)

export QLOUD_SSL_USED="false"

export QLOUD_DISCOVERY_USED="false"
export QLOUD_DISCOVERY_NAME="kernel"
export QLOUD_DISCOVERY_PUBLIC_HOST="qloudkernel.service.sd"
export QLOUD_DISCOVERY_PUBLIC_PORT="80"
export QLOUD_DISCOVERY_LOCAL_HOST="qloudkernel"
export QLOUD_DISCOVERY_LOCAL_PORT="8888"

export QLOUD_CONFIG_USED="false"
export QLOUD_CONFIG_NAMESPACE=
export QLOUD_CONFIG_ENVIROMENT=
export QLOUD_CONFIG_TOPIC=

export JAVA_OPTS="--add-opens java.base/jdk.internal.misc=ALL-UNNAMED -Dio.netty.tryReflectionSetAccessible=true -Xms512M -Xmx512M"

$JAVA_HOME/bin/java -Xms512M -Xmx512M -Dlog4j.configurationFile="$SERVER_HOME/agent.xml" -cp "$SERVER_HOME:$SERVER_HOME/classes:$SERVER_HOME/lib/*:$SERVER_HOME/*:$SERVER_HOME/extra/*" com.icos.icosbus.sdk.agent.IcosServiceAgent $1
