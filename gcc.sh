#! /bin/sh

arr=( $@ )	#以”参数1””参数2”...形式保存所有参数


#拷贝room页面背景图
case $1 in
	raidboss)	
		cp html/i/gcard/smart/bg_ev$2.png html.kr/i/gcard/smart/bg_room_raid_boss.png 
		;;
	teambattle)
		cp html/i/gcard/smart/bg_ev$2.png html.kr/i/gcard/smart/bg_room_team_battle.png
		;;
	promotion)
		cp html/i/gcard/smart/bg_ev$2.png html.kr/i/gcard/smart/bg_room_promotion.png
		;;
esac
