./configure --prefix=/usr --docdir=/usr/share/doc/automake-$VERSION
make
make -j4 check
make install
