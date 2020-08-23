#!/bin/sh
if [ -f $0 ]
then
  export $(cat $0 | sed 's/#.*//g' | xargs)
fi