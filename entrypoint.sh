#!/bin/bash

# Update the admin password
/opt/cubecoders/amp/ampinstmgr UpdateInstance ADS01 --setParam UserName $USERNAME --setParam UserPassword $PASSWORD

# Start the server in the background
/opt/cubecoders/amp/ampinstmgr StartInstance ADS01

# Attach to the instance console
/opt/cubecoders/amp/ampinstmgr View ADS01
