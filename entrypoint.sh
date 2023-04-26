#!/bin/bash

# Update the admin password
/opt/cubecoders/amp/ampinstmgr UpdateInstance ADS01 --setParam UserName $USERNAME --setParam UserPassword $PASSWORD

# Start the server in the background
/opt/cubecoders/amp/ampinstmgr StartInstance ADS01

# Sleep for a short period to ensure that the log file has been created
sleep 5

# Tail the instance's log file
exec tail -f /home/amp/.ampdata/instances/ADS01/AMP_Logs/log.txt
