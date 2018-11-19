#!/bin/bash

set -e

mkdir -p /tmp/modul/etc
cp ./etc/app.conf /tmp/modul/etc/$FULL_NAME.conf

envsubst < /tmp/template.service > /tmp/modul/etc/$FULL_NAME.service
     
envsubst < /tmp/template.override.service > /tmp/modul/etc/$FULL_NAME.override.service

envsubst < /tmp/template.override.conf > /tmp/modul/etc/$FULL_NAME.override.conf

ansible-playbook -i /etc/modulbuh/stagings.yml /tmp/deploy.yml -e service_name=$FULL_NAME
