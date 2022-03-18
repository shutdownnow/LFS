LFS_DISK="$1"

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

sudo mkfs -t vfat -I "${LFS_DISK}1"
sudo mkfs -t ext4 -F "${LFS_DISK}2"
