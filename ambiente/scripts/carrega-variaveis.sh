#!/bin/sh

echo "================"

echo $1

if [ -f $1 ]
then
  export $(sed 's/[[:blank:]]//g; /^#/d' $1 | xargs)
fi
