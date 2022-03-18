cat packages.csv | while read line; do
	NAME="`echo $line | cut -d\; -f1`"
	VERSION="`echo $line | cut -d\; -f2`"
	URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
	MURL="${LFS_MIRROR}/$(echo $URL | rev | cut -d\/ -f1 | rev)"
	MD5SUM="`echo $line | cut -d\; -f4`"
	CACHEFILE="$(basename "$URL")"

	if [ ! -f "$CACHEFILE" ]; then
		echo "Downloading from default mirrors site $MURL"
		wget "$MURL"
	fi

	if ! echo "$MD5SUM $CACHEFILE" | md5sum -c > /dev/null; then
		rm -f "$CACHEFILE"
		echo "Verification of $CACHEFILE failed! MD% mismatch!"

		echo "Downloading $URL"
		wget "$URL"
		if ! echo "$MD5SUM $CACHEFILE" | md5sum -c > /dev/null; then
			rm -f "$CACHEFILE"
			echo "Verification of $CACHEFILE failed! MD% mismatch!"
			exit 1
		fi
	fi
done
