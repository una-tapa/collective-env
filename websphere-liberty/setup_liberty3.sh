# Create collective keystores
echo "***** Creating replica keystores and server snippets..."
/opt/ibm/wlp/bin/collective replicate defaultServer --keystorePassword=c3KS --controller=gil:gilpwd@liberty1:9443 --autoAcceptCertificates
echo "***** Copying ready-made server.xml so ignore the snippets.."
cp /opt/ibm/wlp/usr/servers/defaultServer/server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml.org
cp /opt/ibm/wlp/usr/servers/defaultServer/liberty3-replica-server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml
echo "***** Starting server"
/opt/ibm/wlp/bin/server start defaultServer
echo "***** addReplica command "
/opt/ibm/wlp/bin/collective addReplica liberty3:10010 --controller=gil:gilpwd@liberty1:9443 --autoAcceptCertificates
echo "***** Saving keystores  "
cp -r /opt/ibm/wlp/usr/servers/defaultServer/resources /logs/liberty3-keystores-resources
cp -r /opt/ibm/wlp/usr/servers/defaultServer/server.xml /logs/server.xml
