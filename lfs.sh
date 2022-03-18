#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export LFS_DISK=/dev/sdc
export LFS_MIRROR=https://file.colonq.cn/mirrors/lfs/11.1
export MAKEFLAGS='-j16'

if ! grep -q "$LFS" /proc/mounts; then
	source setupdisk.sh "$LFS_DISK"
	sudo mount "${LFS_DISK}2" "$LFS"
	sudo mkdir -pv "${LFS}/boot/efi"
	sudo mount "${LFS_DISK}1" "${LFS}/boot/efi"
	sudo chown -v "$USER" "$LFS"
fi

mkdir -pv $LFS/{tools,sources,etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
	if [ ! -d "$LFS/$i" ]; then
		ln -sv usr/$i $LFS/$i
	fi
done

case $(uname -m) in
   x86_64) mkdir -pv $LFS/lib64 ;;
esac

cp -rf *.sh step* packages.csv "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"

source download.sh

# step1
for package in binutils gcc linux-api-header glibc libstdc++; do
	echo -n ""
	source packageinstall.sh 1 $package
done

# step2
for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
	echo -n ""
	source packageinstall.sh 2 $package
done

chmod ugo+x preparechroot.sh
chmod ugo+x insidechroot*.sh
chmod ugo+x teardownchroot.sh

for script in insidechroot*;do
	./chroot_bash.sh "$LFS" -c "/sources/$script"
done
