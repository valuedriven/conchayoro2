#!/bin/sh

containerId=$(docker ps -q --filter name=containerServer)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=containerClient)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=containerDB)

if [ ! -z $containerId ]
then
 docker kill $containerId
fi
