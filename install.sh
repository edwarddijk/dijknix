#!/usr/bin/env sh

# Variables
disk=/dev/sda

# Partitions
partition1=${disk}1
partition2=${disk}2
partition3=${disk}3
mount_options="noatime,compress=zstd,ssd"

echo "Selected disk: $disk"
echo "EFI Partition: $partition1"
echo "Swap Partition: $partition2"
echo "Root Partition: $partition3"

echo "Wiping disk: $disk"
sgdisk -Z $disk

echo "Setting default block size on: $disk"
sgdisk -a 2048 -o $disk

echo "Creating a 512M efiboot partition on: $disk"
sgdisk -n 1::+512M --typecode=1:ef00 --change-name=1:efiboot $disk

echo "Creating a 8G swap partition on: $disk"
sgdisk -n 2::+8G --typecode=2:8200 --change-name=2:Swap $disk

echo "Creating a Linux partition on: $disk"
sgdisk -n 3::-0 --typecode=3:8300 --change-name=3:Linux $disk

echo "Re-reading the partition table"
partprobe $disk


mkfs.vfat -F32 -n "efiboot" $partition1
mkswap $partition2
swapon $partition2

cryptsetup luksFormat -v -y $partition3
cryptsetup open $partition3 ROOT

mkfs.btrfs -L ROOT /dev/mapper/ROOT

mount -t btrfs /dev/mapper/ROOT /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@.snapshots

umount /mnt

mount -t btrfs -o subvol=@,$mount_options /dev/mapper/ROOT /mnt

mkdir /mnt/{boot,home,var,tmp,.snapshots}

mount -o defaults $partition1 /mnt/boot
mount -t btrfs -o subvol=@home,$mount_options /dev/mapper/ROOT /mnt/home
mount -t btrfs -o subvol=@var,$mount_options /dev/mapper/ROOT /mnt/var
mount -t btrfs -o subvol=@tmp,$mount_options /dev/mapper/ROOT /mnt/tmp
mount -t btrfs -o subvol=@.snapshots,$mount_options /dev/mapper/ROOT /mnt/.snapshots
