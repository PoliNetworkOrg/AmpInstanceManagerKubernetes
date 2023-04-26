#!/bin/bash

# Update the admin password
/opt/cubecoders/amp/ampinstmgr UpdateInstance ADS01 --setParam UserName $USERNAME --setParam UserPassword $PASSWORD

# Start the server
exec /opt/cubecoders/amp/ampinstmgr StartInstance ADS01
exec /opt/cubecoders/amp/ampinstmgr View ADS01
