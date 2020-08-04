#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

echo "Iniciando ajustes de pós instalação do Nexus...\n"

groovyexec=$NEXUS_HOME/system/org/codehaus/groovy/groovy-all/2.4.15/groovy-all-2.4.15.jar
host="http://"$ARTIFACT_REPO_HOST:$ARTIFACT_REPO_PORT
username=$ARTIFACT_REPO_USER
newPassword=$ARTIFACT_REPO_PASSWORD
password="$(cat /nexus-data/admin.password)"

changePasswordRest=$host"/service/rest/beta/security/users/"$username"/change-password"

echo "Alteração da senha padrão\n"
curl -v -X PUT -u $username:$password --header "Content-Type: text/plain" $changePasswordRest -d $newPassword 

echo "Publicação de script com cadastro de novos usuários"
scriptName="security2"
file="deploy-config/nexus/security.groovy"
java -jar $groovyexec -v -Dgroovy.grape.report.downloads=true -Dgrape.config=grapeConfig.xml deploy-config/nexus/addUpdateScript.groovy -u "$username" -p "$password" -n "$scriptName" -f "$file" -h "$host"
echo "Publicado arquivo $file como script $scriptName\n"

securityScriptRest=$host/service/rest/v1/script/$scriptName/run
echo "Execução de script $scriptName com rest $securityScriptRest"
curl -v -X POST -u $username:$newPassword --header "Content-Type: text/plain" $securityScriptRest 
echo "Script $scriptName executado com sucesso\n"

echo "Ajustes de pós instalação concluídos"