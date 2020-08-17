#!/bin/sh

printenv

containerId=$(docker ps -q --filter name=clientHost})

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=serverHost)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=dbHost)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi
