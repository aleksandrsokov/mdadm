#!/bin/bash
#clear dev
mdadm --zero-superblock --force /dev/sd{c,d,e,f,g}
#create raid 10
mdadm --create --verbose /dev/md127 -l 10 -n 4 /dev/sd{c,d,e,f}
#add info to config
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf 
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
update-initramfs -u
#degree
mdadm /dev/md127 --fail /dev/sdc
mdadm /dev/md127 --remove /dev/sdc
#add new disk 
mdadm /dev/md127 --add /dev/sdg
#add hotspare
mdadm /dev/md127 --add /dev/sdc
#add GPT and create partition
parted -s /dev/md127 mklabel gpt
parted /dev/md127 mkpart primary ext4 0% 20%
parted /dev/md127 mkpart primary ext4 20% 40%
parted /dev/md127 mkpart primary ext4 40% 60%
parted /dev/md127 mkpart primary ext4 60% 80%
parted /dev/md127 mkpart primary ext4 80% 100%
#create file sistem
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md127p$i; done
#create folders to mount
mkdir -p /raid/part{1,2,3,4,5}
#update fstab
for i in $(seq 1 5); do echo "/dev/md127p$i /raid/part$i ext4 defaults 0 0" >> /etc/fstab; done
mount -a
init 6