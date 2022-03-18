#!/bin/bash

export LFS="$1"
shift

if [ "$LFS" == "" ]; then
	exit 1
fi

if [ "$(pwd)" != "$LFS/sources" ]; then
	cp -rf *.sh step* packages.csv "$LFS/sources"
fi

chmod ugo+x preparechroot.sh
sudo ./preparechroot.sh "$LFS"

sudo chroot "$LFS" /usr/bin/env -i \
	HOME=/root \
	MAKEFLAGS="$MAKEFLAGS" \
	TERM="$TERM" \
	PS1='(lfs chroot) \u:\w\$ ' \
	PATH="/bin:/usr/bin:/sbin:/usr/sbin" \
	LFS="" \
	/bin/bash --login $@

chmod ugo+x teardownchroot.sh
sudo ./teardownchroot.sh "$LFS" "$USER" "$(id -gn)"
