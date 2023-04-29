#!/bin/bash

curl -sSL --fail google.com > /dev/null

if [ $? -ne 0 ]; then
  echo "Error: Unable to access the internet."
  exit 1
fi

# /opt/cubecoders/amp/ampinstmgr --CreateInstance $MODULE ADS01 $IPBINDING $PORT $USERNAME $PASSWORD $LICENCE

# Start the server in the background
# /opt/cubecoders/amp/ampinstmgr StartInstance ADS01

# Continuously view the instance output to keep the container running
while true; do
  # exec tail -n 100 --follow=name /home/amp/.ampdata/instances/ADS01/AMP_Logs/AMPLOG*.log
  sleep 10
done
