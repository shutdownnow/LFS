touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

export LFS=""
cd /sources

# step3
for package in libstdc++ gettext bison perl python texinfo util-linux; do
	echo -n ""
	source packageinstall.sh 3 $package
done

rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /tools
