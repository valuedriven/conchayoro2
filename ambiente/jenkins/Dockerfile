FROM  jenkins/jenkins:2.235.3-lts-alpine

COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY *.txt  /usr/share/jenkins/ref/

USER root

ENV KEY_FILE="conchayoro"
ENV KEY_NAME="conchayoro_key_name"

#ENV JAVA_HOME=/usr/bin/java
ENV SONAR_SCANNER_CLI_VERSION=4.4.0.2170
ENV SONAR_SCANNER_HOME=/sonar-scanner
ENV PATH $PATH:${SONAR_SCANNER_HOME}/bin

RUN echo "Instalando pacotes básicos unzip, curl, sed, openrc, docker, npm e terraform..." &&\
    apk update &&\
    apk add --no-cache unzip curl sed openrc docker npm &&\
    apk add --no-cache terraform --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community &&\
    npm update &&\
    npm install -g git ansible heroku nodejs &&\
    echo "Instalando sonar-scanner..." &&\
    curl -s -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_CLI_VERSION}-linux.zip -o sonarscanner.zip &&\
    echo "unzip..." &&\
    unzip sonarscanner.zip &&\
    echo "rm..." &&\
    rm -rf sonarscanner.zip &&\
    echo "mv..." &&\
    mv sonar-scanner-${SONAR_SCANNER_CLI_VERSION}-linux ${SONAR_SCANNER_HOME} &&\
    echo "Instalando Heroku plugin..." &&\
    heroku plugins:install heroku-config &&\
    echo "Configurando chaves..." &&\
    ssh-keygen -t rsa -b 2048 -C ${KEY_NAME} -N "" -f ~/.ssh/${KEY_FILE} &&\
    chmod 400 ~/.ssh/${KEY_FILE}* &&\
    ssh-keygen -e -m pem -f ~/.ssh/${KEY_FILE}.pub  > ~/.ssh/${KEY_FILE}.pem  &&\
    rc-update add docker boot &&\
    echo "Instalando plugins Jenkins..." &&\
    tr -d '\r' < /usr/share/jenkins/ref/plugins.txt | /usr/local/bin/install-plugins.sh &&\
    sh -c install-plugins.sh 

RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' ${SONAR_SCANNER_HOME}/bin/sonar-scanner

CMD /sbin/tini -- /usr/local/bin/jenkins.sh