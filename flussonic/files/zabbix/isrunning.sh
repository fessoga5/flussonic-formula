#! /bin/sh
/usr/bin/service flussonic status 2>/dev/null | grep "is running" >/dev/null 2>&1
if [ "$?" -eq "0" ]
then
	echo 1
else
	echo 0
fi
