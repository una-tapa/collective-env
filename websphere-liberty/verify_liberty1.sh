echo "***** grep for Warning and errors.."
grep " [W|E] " /logs/messages.log
echo "***** grep for important messages"
grep "JMX" /logs/messages.log
grep "CWWKX9003I" /logs/messages.log
grep "9443" /logs/messages.log
grep "controller" /logs/messages.log
