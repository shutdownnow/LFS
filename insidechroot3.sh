export LFS=""
cd /sources

# chapter8
for package in \
	man-pages iana-etc glibc zlib bzip2 xz zstd file readline \
	m4 bc flex tcl expect dejagnu binutils gmp mpfr mpc attr \
	acl libcap shadow gcc pkg-config ncurses sed psmisc gettext \
	bison grep bash libtool gdbm gperf expat inetutils less perl \
	xml::parser intltool autoconf automake openssl kmod libelf \
	libffi python ninja meson coreutils check diffutils gawk \
	findutils groff efivar popt efibootmgr grub gzip iproute2 \
	kbd libpipeline make patch tar texinfo vim eudev udev-lfs \
	man-db procps-ng util-linux e2fsprogs sysklogd sysvinit; do
	echo -n ""
	source packageinstall.sh 4 $package
done

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete
find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

userdel -r tester
