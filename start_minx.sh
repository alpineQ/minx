#!/bin/bash

source .env

printf -v macaddr "52:16:0A:07:00:%02x" $(( $1 & 0xff ))
qemu-system-x86_64 --enable-kvm -M q35 -m 64M \
	-cpu host -smp 1,sockets=1,cores=1,threads=1 \
	-machine type=pc,accel=kvm \
	-cdrom minx.iso \
	-nographic \
 	-serial mon:stdio \
	-netdev bridge,id=net0 -device virtio-net-pci,netdev=net0,mac=$macaddr
