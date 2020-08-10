#!/bin/sh

export SERVER_HOME=$(cd `dirname $0`; pwd)

kill $(sed -n '1p' $SERVER_HOME/agent.pid)
