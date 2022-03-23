sudo fdisk "$LFS_DISK" << EOF
g
n
128

+1M
t
4
n
1

+512M
t
1
1
n



t
2
23
p
w
EOF

if echo "${LFS_DISK}" | grep -q "^/dev/nvme"; then
	NFLAG="p"
fi

sudo mkfs -t vfat -I "${LFS_DISK}${NFLAG}1"
sudo mkfs -t f2fs -F "${LFS_DISK}${NFLAG}2"

sudo mount "${LFS_DISK}${NFLAG}2" "$LFS"
sudo mkdir -pv "${LFS}${LFS_EFI}"
sudo mount "${LFS_DISK}${NFLAG}1" "${LFS}${LFS_EFI}"

unset NFLAG
