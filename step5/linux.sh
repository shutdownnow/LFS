make mrproper

make defconfig

make

make modules_install

cp -iv arch/x86/boot/bzImage /boot/vmlinuz-$VERSION-lfs-11.1
cp -iv System.map /boot/System.map-$VERSION
cp -iv .config /boot/config-$VERSION

install -d /usr/share/doc/linux-$VERSION
cp -r Documentation/* /usr/share/doc/linux-$VERSION
