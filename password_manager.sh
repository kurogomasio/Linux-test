#!/bin/bash
echo "パスワードマネージャーへようこそ！"

#変数
str1="a"	#仮の初期値設定
str2="Add Password"
str3="Get Password"
str4="Exit"

#Exitと入力するまで選択を繰り返す
while  [ "$str1" != "$str4" ]
do
	read  -p '次の選択肢から入力してください(Add Password/Get Password/Exit)：' str1

	#選択肢によって処理を変える
	case "$str1" in
	$str2)		# Add Password が入力された場合
		read -p 'サービス名を入力してください:' strN
		read -p 'ユーザー名を入力してください:' strU
		read -p 'パスワードを入力してください:' strP
		#入力したデータをpassword_data.txtに保存させる
		dire="password_data.txt"
		#なければ作成する
		echo "サービス名:$strN ユーザー名:$strU パスワード:$strP"  >> $dire
  		gpg -c $dire
    		rm $dire
		echo " パスワードの追加は成功しました。"
	;;
	$str3)# Get Password が入力された場合
		read -p ' サービス名を入力してください:' strS
  		gpg password_data.txt.gpg
		# サービス名が保存されていなかった場合
		if !  grep -qw  $strS password_data.txt; then
			echo "そのサービスは登録されていません。"
			# サービス名が保存されていた場合
		else
			grep -E $strS password_data.txt | awk '{print $1}'
			grep -E $strS password_data.txt | awk '{print $2}'
			grep -E $strS password_data.txt | awk '{print $3}'
		fi
  		rm password_data.txt
	;;

	$str4)# Exit が入力された場合
	;;

	*)# Add Password/Get Password/Exit 以外が入力された場合
		echo " 入力が間違えています."
	esac
done
#終了
echo "Thank you"


