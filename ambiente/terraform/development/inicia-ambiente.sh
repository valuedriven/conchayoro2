#!/bin/sh

containerId=$(docker ps -q --filter name=$0})

echo "Container 1"
echo $containerId

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=$1)

echo "Container 2"
echo $containerId

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

echo "Container 3"
echo $containerId

containerId=$(docker ps -q --filter name=$2)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

NETWORK_NAME=localNetwork
if [ -z $(docker network ls --filter name=^${NETWORK_NAME}$ --format="{{ .Name }}") ] ; then 
     docker network create ${NETWORK_NAME} ; 
fi
