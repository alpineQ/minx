#!/bin/bash

source .env

echo "Stopping interfaces"
ip link set dev ${BRNAME} down
ip link delete ${BRNAME}

