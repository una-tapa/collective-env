######################################
# Use websphere-liberty:full that has collective feature
######################################
## FROM websphere-liberty:full
## FROM websphere-liberty:21.0.0.11-full-java8-ibmjava-ubi
FROM ibmcom/websphere-liberty:21.0.0.11-full-java8-ibmjava-ubi
USER root
# RUN apt-get update
######################################
# install utilities, ping, emacs, wcp
######################################
# RUN apt-get install -y iputils-ping
# RUN apt-get install -y emacs
# RUN apt-get -y install openssh-client
######################################
# Ensure collective feature is installed
######################################
RUN /opt/ibm/wlp/bin/installUtility install --acceptLicense collectiveController-1.0
######################################
# Default keystore password settings interfere with collective commands.
######################################
RUN mv /opt/ibm/wlp/usr/servers/defaultServer/server.env /opt/ibm/wlp/usr/servers/defaultServer/server.env.org
RUN mv /opt/ibm/wlp/usr/servers/defaultServer/configDropins /opt/ibm/wlp/usr/servers/defaultServer/configDropins.org
######################################
# COPY ready-made server.xml 
######################################
COPY collective-controller-liberty1-server.xml /opt/ibm/wlp/usr/servers/defaultServer/
COPY liberty2-replica-server.xml /opt/ibm/wlp/usr/servers/defaultServer/
COPY liberty3-replica-server.xml /opt/ibm/wlp/usr/servers/defaultServer/
COPY liberty4-member-to-liberty1-controller.xml /opt/ibm/wlp/usr/servers/defaultServer/
COPY bootstrap.properties /opt/ibm/wlp/usr/servers/defaultServer/bootstrap.properties
# COPY jvm.options /opt/ibm/wlp/usr/servers/defaultServer/jvm.options.save
COPY jvm.options /opt/ibm/wlp/usr/servers/defaultServer/jvm.options
######################################
# COPY setup script and reminder text
######################################
COPY remindme.txt /
# liberty1
COPY setup_liberty1.sh /
COPY verify_liberty1.sh /
COPY start_server.sh /
COPY stop_server.sh /
# liberty2,3,4
COPY setup_liberty2.sh /
COPY setup_liberty3.sh /
COPY setup_liberty4.sh /
######################################
# chmod
######################################
RUN chmod +x setup_liberty1.sh
RUN chmod +x setup_liberty2.sh
RUN chmod +x setup_liberty3.sh
RUN chmod +x setup_liberty4.sh
RUN chmod +x verify_liberty1.sh
RUN chmod +x start_server.sh
RUN chmod +x stop_server.sh
# keep container running 
CMD tail -f /dev/null