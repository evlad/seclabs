#!/bin/bash

gen_username ()
{
	echo student_$1
}

### MAIN

if [ $# != 1 ] ; then
	echo "Usage: $0 NumOfStudents"
	exit 1
else
	numst=$1
	curst=1
	while [ $curst -le $numst ] ; do
		stid=`expr 1000 + $curst`
		stname=`gen_username $curst`
		echo "Removing $stname ..."
		userdel -r $stname
		(( curst++ ))
	done
fi

