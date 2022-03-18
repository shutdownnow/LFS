mkdir -pv /usr/share/fonts/unifont \
	&& gunzip -c ../unifont-13.0.06.pcf.gz > /usr/share/fonts/unifont/unifont.pcf

unset {C,CPP,CXX,LD}FLAGS

./configure --prefix=/usr			\
            --sysconfdir=/etc		\
            --disable-efiemu		\
            --with-platform=efi		\
            --disable-werror		\
	&& make

make install \
	&& mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

mountpoint /sys/firmware/efi/efivars || mount -v -t efivarfs efivarfs /sys/firmware/efi/efivars

grub-install --recheck --bootloader-id=LFS --efi-directory=/boot/efi --boot-directory=/boot/efi
