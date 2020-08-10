#!/bin/bash

cp deploy-config/jenkins/*.groovy /usr/share/jenkins/ref/init.groovy.d/

cp deploy-config/jenkins/*.txt  /usr/share/jenkins/ref/

mkdir /usr/share/jenkins/email-templates

cp deploy-config/jenkins/email.template  /usr/share/email-templates/

tr -d '\r' < /usr/share/jenkins/ref/plugins.txt | /usr/local/bin/install-plugins.sh

sh -c install-plugins.sh

echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

/sbin/tini -- /usr/local/bin/jenkins.sh

echo "Inicialização completa"





