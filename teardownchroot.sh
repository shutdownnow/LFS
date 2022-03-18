#!/bin/bash

export LFS="$1"
export DIROWNER="$2"
export DIRGROUP="$3"

if [ "$LFS" == "" ]; then
	exit 1
fi

if [ -h $LFS/dev/shm ]; then
	rm -rf $LFS/$(readlink $LFS/dev/shm)
fi

umount $LFS/{run,sys,proc}
umount $LFS/dev/{pts,}
rm -f $LFS/dev/{console,null}

chown -R $DIROWNER:$DIRGROUP $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
   x86_64) chown -R $DIROWNER:$DIRGROUP $LFS/lib64 ;;
esac
