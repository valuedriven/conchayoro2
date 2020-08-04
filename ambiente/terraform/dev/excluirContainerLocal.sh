#!/bin/sh

containerId=$(docker ps -q --filter name=containerLocal)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi
