FROM  alpine:3.12.0

ENV KEY_FILE="conchayoro"
ENV KEY_NAME="conchayoro_key_name"

RUN apk update && \
    apk add --no-cache openssh &&\
    apk add --no-cache terraform --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community &&\
    ssh-keygen -t rsa -b 2048 -C ${KEY_NAME} -N "" -f ~/.ssh/${KEY_FILE} &&\
    chmod 400 ~/.ssh/${KEY_FILE}* 

VOLUME /home