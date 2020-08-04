#!/bin/sh

PROJECT_REPO_USER=
ARTIFACT_HOST_USER=
QUALITY_HOST_USER=

PROJECT_REPO_HOST=https://gitlab.com/$PROJECT_REPO_USER/conchayoro.git
PROJECT_ENV_PATH=/root/conchayoro/ambiente

echo "===> Configuração do ambiente remoto"

echo "===> Configuração Jenkins"
docker-compose --compatibility up -d jenkins

echo "===> Configuração Nexus"
echo "===> Clonando repositório no host Nexus"
ssh -t $ARTIFACT_HOST_USER "git clone $PROJECT_REPO_HOST" -o StrictHostKeyChecking=no
echo "===> Copiando arquivos para host Nexus"
scp .credenciais .env $ARTIFACT_HOST_USER:$PROJECT_ENV_PATH
echo "===> Iniciando conteiner Nexus"
ssh -t $ARTIFACT_HOST_USER "cd $PROJECT_ENV_PATH && docker-compose --compatibility up -d nexus && docker-compose exec nexus sh /deploy-config/nexus/init.sh"

echo "===> Configuração Sonar"
echo "===> Clonando repositório no host Sonar"
ssh -t $QUALITY_HOST_USER "git clone $PROJECT_REPO_HOST" -o StrictHostKeyChecking=no
echo "===> Copiando arquivos para host Sonar"
scp .credenciais .env $QUALITY_HOST_USER:$PROJECT_ENV_PATH
echo "===> Iniciando conteiner"
ssh -t $QUALITY_HOST_USER "cd $PROJECT_ENV_PATH && docker-compose --compatibility up -d sonar"

echo "===> Configuração do ambiente remoto concluída com sucesso!!"