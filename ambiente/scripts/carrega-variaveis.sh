#!/bin/sh
if [ -f $0 ]
then
  export $(sed 's/[[:blank:]]//g; /^#/d' .env | xargs)
fi