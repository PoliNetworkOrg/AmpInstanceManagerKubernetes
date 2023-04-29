#!/bin/bash

# Start the server in the background
/opt/cubecoders/amp/ampinstmgr StartInstance ADS01

# Continuously view the instance output to keep the container running
while true; do
  exec tail -n 100 --follow=name /home/amp/.ampdata/instances/ADS01/AMP_Logs/AMPLOG*.log
  sleep 10
done
