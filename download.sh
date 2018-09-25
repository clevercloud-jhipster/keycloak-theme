#!/bin/bash
wget https://repo1.maven.org/maven2/org/keycloak/keycloak-server-dist/4.4.0.Final/keycloak-server-dist-4.4.0.Final.tar.gz
tar xzf keycloak-server-dist-4.4.0.Final.tar.gz
JBOSS_HOME="/home/bas/app_dc143183-9edc-45a0-acab-e28ef5f70bb6/keycloak-4.4.0.Final" mvn clean install
sed -i -e 's/<theme>/&\n	      <modules>\n    <module>com.clevercloud.theme<\/module>\n        <\/modules>/' $JBOSS_HOME/standalone/configuration/standalone.xml
##################
# Add admin user #
##################

if [ $KEYCLOAK_USER ] && [ $KEYCLOAK_PASSWORD ]; then
    $JBOSS_HOME/bin/add-user-keycloak.sh --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD
fi

############
# DB setup #
############

mkdir -p $JBOSS_HOME/modules/system/layers/base/org/postgresql/jdbc/main
curl -L http://central.maven.org/maven2/org/postgresql/postgresql/$JDBC_POSTGRES_VERSION/postgresql-$JDBC_POSTGRES_VERSION.jar > $JBOSS_HOME/modules/system/layers/base/org/postgresql/jdbc/main/postgres-jdbc.jar
cp ./module.xml $JBOSS_HOME/modules/system/layers/base/org/postgresql/jdbc/main

$JBOSS_HOME/bin/jboss-cli.sh --file=./standalone-configuration.cli
