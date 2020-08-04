#!/bin/bash

name=$1

server="http://"$ARTIFACT_REPO_HOST:$ARTIFACT_REPO_PORT
username=$ARTIFACT_REPO_USER
password=$ARTIFACT_REPO_PASSWORD

printf "Running Integration API Script $name\n\n"

curl -v -X POST -u $username:$password --header "Content-Type: application/json" $server"/service/rest/v1/script/$1/run"
