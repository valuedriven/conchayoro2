#!/bin/bash

server="http://"$ARTIFACT_REPO_HOST:$ARTIFACT_REPO_PORT
username=$ARTIFACT_REPO_USER
password=$ARTIFACT_REPO_PASSWORD

echo "Aguardando conclusão da instalação do Nexus..."
until curl --fail --insecure $server > /dev/null; do   
   sleep 10
done

oldPassword="$(cat /nexus-data/admin.password)"
changePasswordRest=$server"/service/rest/beta/security/users/"$username"/change-password" 

echo "Alteração da senha padrão do administrador"
echo "usuário: "$username
echo "senha: "$password
echo "velha senha: "$oldPassword
echo "rest: "$changePasswordRest
curl -v -X PUT -u $username:$oldPassword --header "Content-Type: text/plain" $changePasswordRest -d $password


echo "Liberação de acesso anônimo"
curl -v -X POST -u $username:$password --header "Content-Type: text/plain" $server"/service/rest/v1/script/anonymous/run" -d "true"

cd /deploy-config/nexus

echo "Inclusão e execução de script de criação de grupo"
sh ./create.sh groups.json
sh ./run.sh fileblobstore

echo "Inclusão e execução de script de criação de repositório"
sh ./create.sh repository.json
sh ./run.sh Docker

echo "..."
echo "Ajustes de pós instalação concluídos"