export LFS=""
cd /sources

source packageinstall.sh 5 cpio
source step5/initramfs.sh

cat > /etc/fstab << "EOF"
# Begin /etc/fstab
# ⽂件系统 挂载点  类型  选项    转储 检查
                顺序
/dev/nvme0n1p2 / f2fs defaults 1 1
/dev/nvme0n1p1 /boot/efi vfat defaults 0 1
#/dev/<yyy> swap swap pri=1 0 0
proc /proc  proc nosuid,noexec,nodev 0  0
sysfs /sys  sysfs nosuid,noexec,nodev 0  0
devpts /dev/pts devpts gid=5,mode=620 0 0
tmpfs /run tmpfs defaults 0 0
devtmpfs /dev devtmpfs mode=0755,nosuid 0 0
efivarfs /sys/firmware/efi/efivars efivarfs defaults 0 0
# End /etc/fstab
EOF

source packageinstall.sh 5 linux

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
# End /etc/modprobe.d/usb.conf
EOF

cat > /boot/efi/grub/grub.cfg << EOF
# Begin /boot/efi/grub/grub.cfg
set default=0
set timeout=5

insmod all_video
insmod gfxterm
insmod part_gpt
insmod fat
set root=(hd2,2)

menuentry "GNU/Linux, Linux 5.16.14-lfs-11.1"  {
	linux /boot/vmlinuz-5.16.14-lfs-11.1 root=/dev/nvme0n1p2 ro
}

menuentry "Firmware Setup" {
  fwsetup
}
EOF
