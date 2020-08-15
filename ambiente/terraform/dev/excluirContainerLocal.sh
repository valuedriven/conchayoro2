#!/bin/sh

containerId=$(docker ps -q --filter name=containerLocalServer)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=containerLocalClient)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi
