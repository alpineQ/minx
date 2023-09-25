#!/bin/bash

source .env

echo "Stopping interfaces"
ip link set dev ${BRNAME} down
ip link set dev ${TAPNAME} down
ip link del ${TAPNAME}_p
ip link delete ${BRNAME}

