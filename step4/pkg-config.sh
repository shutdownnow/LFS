./configure --prefix=/usr \
	--with-internal-glib \
	--disable-host-tool \
	--docdir=/usr/share/doc/pkg-config-$VERSION

make
make check
make install
