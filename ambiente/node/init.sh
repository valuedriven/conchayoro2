#!/bin/bash

sh /opt/jboss/wildfly/bin/add-user.sh $APP_SERVER_ADMIN_USER $APP_SERVER_ADMIN_PASSWORD --silent && \

sh /opt/jboss/wildfly/bin/standalone.sh "-b" "0.0.0.0" "-bmanagement" "0.0.0.0"
