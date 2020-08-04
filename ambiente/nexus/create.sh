#!/bin/bash

jsonFile=$1

server="http://"$ARTIFACT_REPO_HOST:$ARTIFACT_REPO_PORT
username=$ARTIFACT_REPO_USER
password=$ARTIFACT_REPO_PASSWORD

printf "Creating Integration API Script from $jsonFile\n\n"

curl -v -u $username:$password --header "Content-Type: application/json" $server"/service/rest/v1/script" -d @$jsonFile

