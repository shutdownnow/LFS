./configure --prefix=/usr \
	--docdir=/usr/share/doc/flex-$VERSION \
	--disable-static

make && make install
ln -sv flex /usr/bin/lex
