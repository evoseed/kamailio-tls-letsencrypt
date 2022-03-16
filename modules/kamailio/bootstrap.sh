#!/bin/bash
SHM_MEM=512
PKG_MEM=64
FILE=/bootstrap.sh

if test -f "$FILE"; then
    echo "Link already present"
else
    ln -s /etc/kamailio/bootstrap.sh /bootstrap.sh
fi

# run kamailio
export PATH_KAMAILIO_CFG=/etc/kamailio/kamailio.cfg
kamailio=$(which kamailio)

# rendering the template of kamailio-local.cfg and tls.cfg
envsubst < /etc/kamailio/template.kamailio-local.cfg > /etc/kamailio/kamailio-local.cfg
envsubst < /etc/kamailio/template.tls.cfg > /etc/kamailio/tls.cfg

# Add my IP
if [ "${IP}" != "" ]
then
    echo "listen=udp:${IP}:5060" >> /etc/kamailio/kamailio-local.cfg
    echo "listen=tcp:${IP}:5060" >> /etc/kamailio/kamailio-local.cfg
    echo "listen=tls:${IP}:5061" >> /etc/kamailio/kamailio-local.cfg
fi

# Test the syntax.
$kamailio -f $PATH_KAMAILIO_CFG -c
echo 'Kamailio will be called using the following environment variables:'
echo -n '$DUMP_CORE is: ' ; echo "${DUMP_CORE}"
echo -n '$SHM_MEM is: ' ; echo "${SHM_MEM}"
echo -n '$PKG_MEM is: ' ; echo "${PKG_MEM}"
echo -n '$ENVIRONMENT is: ' ; echo "${ENVIRONMENT}"

# Run kamailio
$kamailio -f $PATH_KAMAILIO_CFG -m "${SHM_MEM}" -M "${PKG_MEM}" -DD -E -e
