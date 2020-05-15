# Create collective keystores
echo "***** Creating replica keystores and server snippets..."
/opt/ibm/wlp/bin/collective join defaultServer --keystorePassword=m1KS --controller=gil:gilpwd@liberty1:9443 --autoAcceptCertificates
echo "***** Copying ready-made server.xml so ignore the snippets.."
cp /opt/ibm/wlp/usr/servers/defaultServer/server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml.org
cp /opt/ibm/wlp/usr/servers/defaultServer/liberty4-member-to-liberty1-controller.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml
echo "***** Starting server"
/opt/ibm/wlp/bin/server start defaultServer
echo "***** Saving keystores  "
cp -r /opt/ibm/wlp/usr/servers/defaultServer/resources /logs/liberty4-keystores-resources

