#!/bin/bash

gen_password ()
{
	echo "P@ssw0rd${1}_stuDEnt${1}"
}

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
		stid=`expr 3000 + $curst`
		stname=`gen_username $curst`
		stpassword=`gen_password $curst`
		echo "Making $stname with password '$stpassword' ..."
		useradd -u $stid -U -m -c "Login for a student" -s /bin/bash $stname
		( echo "$stpassword" ; echo "$stpassword" ) | passwd $stname
		(( curst++ ))
	done
fi

