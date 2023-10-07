#!/bin/bash

source .env

sudo ip tuntap add dev ${TAPNAME}_$1 mode tap || {
	echo "Failed to create tap interface"
	exit 1
}
sudo ip link set dev ${TAPNAME}_$1 master ${BRNAME} &&
sudo ip link set dev ${TAPNAME}_$1 up
sudo ip link set dev ${BRNAME} up

printf -v macaddr "52:16:0A:07:00:%02x" $(( $1 & 0xff ))
qemu-system-x86_64 --enable-kvm -M q35 -m 128M \
	-cpu host -smp 1,sockets=1,cores=1,threads=1 \
	-machine type=pc,accel=kvm \
	-cdrom minx.iso \
	-drive file=./minx/agent.iso,format=raw,index=0,media=cdrom \
	-nographic \
 	-serial mon:stdio \
	-netdev tap,id=net0,ifname=${TAPNAME}_$1,script=no,downscript=no \
    -device virtio-net-pci,netdev=net0,id=net0,mac=$macaddr

sudo ip link set dev ${TAPNAME}_$1 down
sudo ip link del ${TAPNAME}_$1
