./configure --prefix=/usr --disable-static && make

make install

install -v -m755 -d /usr/share/doc/popt-$VERSION
install -v -m644 doxygen/html/* /usr/share/doc/popt-$VERSION
