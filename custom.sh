#! /bin/sh

arr=( $@ )	#以”参数1””参数2”...形式保存所有参数
command=$1

#定义常量
pathItem=~/sg-gcard-kr/html.kr/i/gcard/common/item
pathShop=~/sg-gcard-kr/html.kr/i/gcard/common/item/shop
pathBanner=~/sg-gcard-kr/html.kr/i/gcard/gacha/hall_banner

#card images
pathCard=~/Movies/jpg/
tmpFile=${pathCard}tmp

#scp file check host
function check_host()
{
	case $1 in
		dev02)
			hostip="54.249.47.219"
			;;
		beta)
			hostip="54.249.19.134"
			;;
		beta2)
			hostip="54.250.186.215"	
			;;
		dev08)
			hostip="54.250.141.112"
			;;
	esac
	# return $hostip;
}

function item_copy()
{
	#find $1 -name "$2*" > ~/tmp
	ls -1 $1 | grep $2 > ~/tmp
	for i in $(cat ~/tmp | awk -F "$2" '{print $2}')
	do
		cp $1/$2$i $3/$4$i
	done
	rm ~/tmp
	echo "copy item ok!"
}

case ${command} in
	item_to_item)
		item_copy ${pathItem} $2 ${pathItem} $3;
		;;
	item_to_shop)
		item_copy ${pathItem} $2 ${pathShop} $3;
		;;
	shop_to_shop)
		item_copy ${pathShop} $2 ${pathShop} $3;
		;;
	shop_to_item)
		item_copy ${pathShop} $2 ${pathItem} $3;
		;;
	banner)
		cp ${pathBanner}/$2\_190.jpg ${pathBanner}/$3\_190.jpg
		cp ${pathBanner}/$2\_230.jpg ${pathBanner}/$3\_230.jpg
		cp ${pathBanner}/$2\_240.jpg ${pathBanner}/$3\_240.jpg
		cp ${pathBanner}/$2\_456.jpg ${pathBanner}/$3\_456.jpg
		cp ${pathBanner}/$2\_640.jpg ${pathBanner}/$3\_640.jpg
		;;
	scp_get)
		check_host $2;
		for i in "${arr[@]:2}"
		do
			scp -r -i ~/kr_white.pem mgsys@"${hostip}":~/sg-gcard-kr/${i} ~/sg-gcard-kr/${i}
		done
		;;
	scp_push)
		check_host $2;
		for i in "${arr[@]:2}"
		do
			scp -r -i ~/kr_white.pem ~/sg-gcard-kr/${i} mgsys@"${hostip}":~/sg-gcard-kr/${i}
		done
		;;
	csv_merge_ko)
		./gccenv i18n csv-merge conf/gcard/locales/ko.csv $2 > tmp.csv
		mv tmp.csv conf/gcard/locales/ko.csv
		echo "merge ko.csv ok!"
		;;
	csv_merge)
		./gccenv i18n csv-merge $2 $3 > $4
		;;
	card_psd)
		for i in "${arr[@]:1}"			
		do
			cp ~/Pictures/project/svn_white/03Localization/KR/Card/PSD/$i\.psd ~/Movies/psd/
		done
		echo "card num:" $(ls ~/Movies/psd/ | wc -l)
		;;
	card_svn)
		cp ~/Movies/psd/*psd ~/Pictures/project/svn_white/03Localization/KR/Card/PSD/
		;;
	card_mv)
		ls ${pathCard} | grep -v 'tmp' | grep -v '_special' | grep -v '_'  > ${tmpFile}

		if [ ! -s ${tmpFile} ]; then 
			echo "no file change!"
		else
			for i in $(cat ${tmpFile} | awk -F '.' '{print $1}')
			do
				if [ ! $3 ]; then
					echo $i\_$2\_special\.jpg
					mv ${pathCard}$i\.jpg ${pathCard}$i\_$2\_special\.jpg
				else
					echo $i\_$2\.jpg
					mv ${pathCard}$i\.jpg ${pathCard}$i\_$2\.jpg
				fi
			done
		fi
		rm ${tmpFile}
		;;
esac
