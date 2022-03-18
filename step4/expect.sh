./configure --prefix=/usr \
--with-tcl=/usr/lib \
--enable-shared \
--mandir=/usr/share/man \
--with-tclinclude=/usr/include

make && make install
ln -svf expect$VERSION/libexpect$VERSION.so /usr/lib
