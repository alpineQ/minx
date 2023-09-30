#!/bin/bash

source .env

ip link add name ${BRNAME} type bridge && \
ip address add ${TAPADDR} dev ${BRNAME} || {
	echo "Failed to create bridge"
	ip link set dev ${BRNAME} down
	ip link delete ${BRNAME}
	exit 1
}
