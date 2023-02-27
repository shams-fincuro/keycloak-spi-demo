FROM jboss/keycloak:12.0.3

ADD standalone.xml /opt/jboss/keycloak/standalone/configuration/standalone.xml
ADD standalone-ha.xml /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml
ADD resources /opt/jboss/keycloak/standalone/deployments

# JGROUPS ports for clustering outside same host
EXPOSE 55200/udp
EXPOSE 7600

ENV KEYCLOAK_DEFAULT_THEME=fincuro-theme
ADD themes/fincuro-theme /opt/jboss/keycloak/themes/fincuro-theme/login
