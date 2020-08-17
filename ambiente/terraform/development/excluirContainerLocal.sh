#!/bin/sh

containerId=$(docker ps -q --filter name=${var.ClientHost})

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=${var.ServerHost})

if [ ! -z $containerId ]
then
 docker kill $containerId
fi

containerId=$(docker ps -q --filter name=${var.DBHost})

if [ ! -z $containerId ]
then
 docker kill $containerId
fi
