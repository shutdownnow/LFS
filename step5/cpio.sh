sed -i '/The name/,+2 d' src/global.c

./configure --prefix=/usr \
            --enable-mt   \
            --with-rmt=/usr/libexec/rmt &&
make &&
makeinfo --html            -o doc/html      doc/cpio.texi &&
makeinfo --html --no-split -o doc/cpio.html doc/cpio.texi &&
makeinfo --plaintext       -o doc/cpio.txt  doc/cpio.texi

make install &&
install -v -m755 -d /usr/share/doc/cpio-$VERSION/html &&
install -v -m644    doc/html/* \
                    /usr/share/doc/cpio-$VERSION/html &&
install -v -m644    doc/cpio.{html,txt} \
                    /usr/share/doc/cpio-$VERSION

install -v -m644 doc/cpio.{pdf,ps,dvi} \
                 /usr/share/doc/cpio-$VERSION
