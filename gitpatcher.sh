#! /bin/bash

path=$1
specfile="$1$2"
patches_failed=0
patches_succ=0

for i in `cat $specfile|awk '/^Patch[0-9]+:/ {print $2}'`
do
	echo -e "\n---------------------\nProcessing patch" $i "\n\n"
	patch -p1 < "$path"$i
	if [ $? -eq 0 ]
	then
		git add -A && git commit -m "applied patch "$i && echo "Commit finished correctly"
		test $? -ne 0 && echo "Commit failed"
		
	else
		echo "Patch $i failed"
		patches_failed=$((patches_failed+1))
	fi
done
echo -e "\n-------------------------------\n-------------------------------"
echo "Patches successfull: " $patches_succ
echo "Patches failed: " $patches_failed
