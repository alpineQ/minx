# Pretty minimal buildroot+qemu image
## Build and run
Build image
``` bash
wget https://buildroot.org/downloads/buildroot-2023.02.4.tar.xz
tar xvf buildroot-2023.02.4.tar.xz
cd buildroot-2023.02.4/
cp -r ../board/* board/ && cp ../minx_defconfig configs/
make O=build.minx minx_defconfig
cd build.minx/
make -j
cp images/rootfs.iso9660 ../../minx.iso
```
Run qemu with ip `10.7.0.27`
``` bash
sudo ./start_network.sh
./run_minx.sh 27
sudo ./stop_network.sh
```
Credentials `root:root`

## Network
Network configuration in `.env`
``` bash
export TAPNAME=tapm
export BRNAME=br0
export TAPADDR="10.7.0.100/16"
```
