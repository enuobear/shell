#! /bin/sh

arr=( $@ )

./gccenv i18n csv-filter \
-notreg '.*' \
for i in "${arr[@]:0}"
do
	echo -reg "'$i'" '\'
done
< conf/gcard/locales/ja.csv > tmp.csv
