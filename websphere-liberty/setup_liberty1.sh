# create collective keystores
echo "***** Creating collective keystores and server snippets..."
/opt/ibm/wlp/bin/collective create defaultServer --keystorePassword=c1KS 
echo "***** Copying ready-made server.xml so ignore the snippets.."
cp /opt/ibm/wlp/usr/servers/defaultServer/server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml.org
cp /opt/ibm/wlp/usr/servers/defaultServer/collective-controller-liberty1-server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml
echo "***** Starting server"
/opt/ibm/wlp/bin/server start defaultServer
echo "***** Saving keystores  "
cp -r /opt/ibm/wlp/usr/servers/defaultServer/resources /logs/liberty1-keystores-resources

