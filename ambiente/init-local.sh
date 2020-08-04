#!/bin/sh

echo "Configuração do ambiente local"

docker-compose --compatibility up -d --build
  
docker-compose exec nexus sh /deploy-config/nexus/init.sh

