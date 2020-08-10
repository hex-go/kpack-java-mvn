@echo off

if not defined SERVER_HOME goto set_server_home

:cont
if not defined JAVA_HOME goto no_java_home

set QLOUD_SSL_USED=false

set QLOUD_DISCOVERY_USED=false
set QLOUD_DISCOVERY_NAME=kernel
set QLOUD_DISCOVERY_PUBLIC_HOST="qloudkernel.service.sd"
set QLOUD_DISCOVERY_PUBLIC_PORT="80"
set QLOUD_DISCOVERY_LOCAL_HOST="qloudkernel"
set QLOUD_DISCOVERY_LOCAL_PORT="8888"

set QLOUD_CONFIG_USED=false
set QLOUD_CONFIG_NAMESPACE=
set QLOUD_CONFIG_ENVIROMENT=
set QLOUD_CONFIG_TOPIC=

set JAVA_OPTS=--add-opens java.base/jdk.internal.misc=ALL-UNNAMED -Dio.netty.tryReflectionSetAccessible=true -Xms512M -Xmx512M

"%JAVA_HOME%\bin\java" -Xms512M -Xmx512M -Dlog4j.configurationFile="%SERVER_HOME%\agent.xml" -cp "%SERVER_HOME%;%SERVER_HOME%\classes;%SERVER_HOME%\lib\*;%SERVER_HOME%\*;%SERVER_HOME%\extra\*" com.icos.icosbus.sdk.agent.IcosServiceAgent %1

goto end

:no_java_home
echo ERROR: Set JAVA_HOME to the path where the J2SE 1.8 is installed
goto end 

:set_server_home
set SERVER_HOME=%~dp0
goto cont

:end
