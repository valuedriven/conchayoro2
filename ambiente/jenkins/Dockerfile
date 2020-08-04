FROM  jenkins/jenkins:2.235.3-lts-alpine

COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY *.txt  /usr/share/jenkins/ref/

USER root

ENV KEY_FILE="conchayoro"
ENV KEY_NAME="conchayoro_key_name"

RUN apk update && \
    apk add --no-cache python3 py3-pip groff openrc docker ansible git maven openjdk8-jre tzdata nodejs npm &&\
    apk add --no-cache terraform --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community &&\
    npm install -g heroku &&\
    heroku plugins:install heroku-config &&\
    ssh-keygen -t rsa -b 2048 -C ${KEY_NAME} -N "" -f ~/.ssh/${KEY_FILE} &&\
    chmod 400 ~/.ssh/${KEY_FILE}* &&\
    ssh-keygen -e -m pem -f ~/.ssh/${KEY_FILE}.pub  > ~/.ssh/${KEY_FILE}.pem  &&\
    rc-update add docker boot &&\
    tr -d '\r' < /usr/share/jenkins/ref/plugins.txt | /usr/local/bin/install-plugins.sh && \
    sh -c install-plugins.sh 

CMD /sbin/tini -- /usr/local/bin/jenkins.sh
