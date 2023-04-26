#!/bin/bash

# Update the admin password
/opt/cubecoders/amp/ampinstmgr UpdateInstance ADS01 --setParam UserName $USERNAME --setParam UserPassword $PASSWORD

# Start the server in the background
/opt/cubecoders/amp/ampinstmgr StartInstance ADS01

# Continuously view the instance output to keep the container running
while true; do
  /opt/cubecoders/amp/ampinstmgr View ADS01
  sleep 10
done
