Keycloak Clever Cloud Theme
===========================================

You can either deploy the themes by copying to the themes folder or as modules.


## Deploy on Clever Cloud

Make sure you replace the application path for your deployment. Keycloak also requires a linked PostgreSQL addon.

```
CC_PRE_BUILD_HOOK=./download.sh
DB_NAME=PostgreSQL
DB_VENDOR=postgres
JAVA_VERSION=8
JBOSS_HOME=/home/bas/app_dc143183-9edc-45a0-acab-e28ef5f70bb6/keycloak-4.3.0.Final
JDBC_POSTGRES_VERSION=42.2.2
KEYCLOAK_HOME=/home/bas/app_dc143183-9edc-45a0-acab-e28ef5f70bb6/keycloak-4.3.0.Final
KEYCLOAK_PASSWORD=admin
KEYCLOAK_USER=admin
MAVEN_DEPLOY_GOAL=exec:exec -Dexec.executable=./run.sh
PORT=8080
SMTP_EMAIL=sso@clever-cloud.com
SMTP_PASSWORD=279d93399776b

```


### Copy

Simplest way to deploy the themes is to copy `src/main/resources/theme/*` to `themes/`.


### Module

Change `<properties>` into pom.xml
   
    `<KEYCLOAK_HOME>**PATH-YOUR_KEYCLOAK-HOME**</KEYCLOAK_HOME>`    

Alternatively you can deploy as modules. This can be done by first running:

    mvn clean install
    
Then open `standalone/configuration/standalone.xml` and register the theme module by adding:

    <theme>
        ...
        <modules>
            <module>org.keycloak.onkalo.themes</module>
        </modules>
    </theme>

One thing to note is that to change the admin console for the master admin console (`/auth/admin`) you need to change the theme for the master realm. Changing the admin console theme for any other realms will only change the admin console for that specific realm (for example `/auth/admin/myrealm/console`).
