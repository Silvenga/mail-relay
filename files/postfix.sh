#!/bin/bash

CONFIG_SCRIPT="/config.sh"

echo "Executing $CONFIG_SCRIPT."
if [ -f $CONFIG_SCRIPT ]; then
    echo "Config script $CONFIG_SCRIPT found, will run."
    /bin/bash $CONFIG_SCRIPT
    echo "Script executed and exited with code $?."
else
    echo "Config script $CONFIG_SCRIPT not found, will not run."
fi

echo "Configuring configuration overrides for docker."

# Update aliases database. It's not used, but postfix complains if the .db file is missing
postalias /etc/postfix/aliases

postconf -e maillog_file=/dev/stdout

echo "Deleting old pid files."
rm -rf /var/spool/postfix/pid/*

echo "Using the following configurations:"
echo "Configurations start."
postconf -n
echo "Configurations end."

echo "Updating permissions."
/usr/sbin/postfix -c /etc/postfix set-permissions

echo "Starting Postfix."
/usr/sbin/postfix -c /etc/postfix start-fg