#!/bin/bash

source .env

ip link add name ${TAPNAME} type veth peer name ${TAPNAME}_p || {
	echo "Failed to create tap interface"
	exit 1
}
ip address add ${TAPADDR} dev ${TAPNAME} || {
	echo "Failed to set IP for ${TAPNAME}: ${TAPADDR}"
	ip link set ${TAPNAME} down
	ip link del ${TAPNAME}
	exit 1
}
ip link add name ${BRNAME} type bridge && \
ip link set dev ${TAPNAME}_p master ${BRNAME} &&
ip link set dev ${BRNAME} up &&     \
ip link set dev ${TAPNAME} up &&    \
ip link set dev ${TAPNAME}_p up || {
	echo "Failed to create bridge"
	ip link set dev ${BRNAME} down
	ip link set dev ${TAPNAME} down
	ip link del ${TAPNAME}_p
	ip link del ${BRNAME}
	exit 1
}
# ip link add name ${TAPNAME} type veth peer name ${TAPNAME}_p || {
# 	echo "Failed to create tap interface"
# 	exit 1
# }
# ifconfig ${TAPNAME} ${TAPADDR} || {
# 	echo "Failed to set IP for ${TAPNAME}: ${TAPADDR}"
# 	ip link set ${TAPNAME} down
# 	ip link del ${TAPNAME}
# 	exit 1
# }
# brctl addbr ${BRNAME} &&            \
# brctl addif ${BRNAME} ${TAPNAME}_p && \
# ip link set dev ${BRNAME} up &&     \
# ip link set dev ${TAPNAME} up &&    \
# ip link set dev ${TAPNAME}_p up || {
# 	echo "Failed to create bridge"
# 	ip link set dev ${BRNAME} down
# 	ip link set dev ${TAPNAME} down
# 	ip link del ${TAPNAME}_p
# 	brctl delbr ${BRNAME}
# 	exit 1
# }
