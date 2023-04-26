#!/bin/bash

# Update the admin password
/opt/cubecoders/amp/ampinstmgr UpdateInstance ADS01 --setParam UserName $USERNAME --setParam UserPassword $PASSWORD

# Start the server in the background
/opt/cubecoders/amp/ampinstmgr StartInstance ADS01

# Wait for the log file to be created
while [ ! -f /home/amp/.ampdata/instances/ADS01/AMP_Logs/log.txt ]; do
  sleep 1
done

# Tail the instance log file to keep the container running
exec tail -f /home/amp/.ampdata/instances/ADS01/AMP_Logs/log.txt
