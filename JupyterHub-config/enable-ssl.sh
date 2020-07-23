#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run this script as root or use sudo"
    exit
fi

mkdir /etc/tljh-ssl
# make ssl directory private
chown root /etc/tljh-ssl
chmod 0600 /etc/tljh-ssl 

# put my cert and key in there
cp sslcerts/cert.pem /etc/tljh-ssl/
cp sslcerts/key.pem /etc/tljh-ssl/

# make key and cert files private
chown root /etc/tljh-ssl/*
chmod 0600 /etc/tljh-ssl/*

# update config
tljh-config set https.enabled true
tljh-config set https.tls.key /etc/tljh-ssl/key.pem
tljh-config set https.tls.cert /etc/tljh-ssl/cert.pem
tljh-config reload proxy
