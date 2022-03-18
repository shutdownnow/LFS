patch -Np1 -i ../efivar-$VERSION-gcc_9-1.patch
make CFLAGS="-O2 -Wno-stringop-truncation"
make install LIBDIR=/usr/lib
