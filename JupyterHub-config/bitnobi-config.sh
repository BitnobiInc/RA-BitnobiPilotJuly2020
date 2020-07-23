#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run this script as root or use sudo"
    exit
fi

# install a component called DockerSpawner
/opt/tljh/hub/bin/python3 -m pip install dockerspawner jupyter_client

cp jupyterhub_config.d/dockerspawner_tljh_config.py /opt/tljh/config/jupyterhub_config.d

# create admin API token for access from Bitnobi
secret_token=$(openssl rand -hex 32)

# add it to jupyterhub configuration
echo "c.JupyterHub.api_tokens = {" > test.txt
echo "    '$secret_token': 'admin'," >> test.txt
echo "}" >>test.txt
echo "c.JupyterHub.admin_access = True" >> test.txt

echo Here is your JupyterHub Admin API token to enter during Bitnobi init:
echo $secret_token

tljh-config reload
