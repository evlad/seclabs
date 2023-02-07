#!/bin/bash

studname=${1:-`whoami`}
studuid=${studname}
studgid=${studname}

basename="$PWD"

score=0
# number of successes: grep -wc success thisfile
# minus the only one for if ; then ; else
# minus function with  such name
maxscore=132

success ()
{
    ((score++))
}

final ()
{
    rating=`echo ${score} / ${maxscore} | bc -l`
    echo "Score ${score} of ${maxscore}; rating is ${rating}"
    exit 0
}
failure ()
{
    echo "Too bad to continue"
    final
}


# paragraph 1
if [ -d "${basename}/${studname}" ] ; then
    success
else
    failure
fi

# paragraph 2
wd="${basename}/${studname}/owner"
if [ -d "${wd}" ] ; then
    success
    if [ -d "${wd}/dir_1" ] ; then
	success
	fname="${wd}/dir_1/file_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-r--------" ] && success
	    [[ "${amode}" =~ ^.r........ ]] && success
	fi
	fname="${wd}/dir_1/file_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-rw-------" ] && success
	    [[ "${amode}" =~ ^.rw....... ]] && success
	fi
	fname="${wd}/dir_1/file_3"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-rwx------" ] && success
	    [[ "${amode}" =~ ^.rwx...... ]] && success
	fi
    fi
    # paragraph 3
    if [ -d "${wd}/dir_2" ] ; then
	success
	fname="${wd}/dir_2/subdir_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "dr--------" ] && success
	    [[ "${amode}" =~ ^.r........ ]] && success
	fi
	fname="${wd}/dir_2/subdir_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "drw-------" ] && success
	    [[ "${amode}" =~ ^.rw....... ]] && success
	fi
	fname="${wd}/dir_2/subdir_3"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "drwx------" ] && success
	    [[ "${amode}" =~ ^.rwx...... ]] && success
	fi
    fi
    # paragraph 4
    if [ -d "${wd}/dir_3" ] ; then
	success
	fname="${wd}/dir_3/file_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    [ "${studuid}" != "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ -f "${fname}" ] && success
	fi
	fname="${wd}/dir_3/file_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ -r "${fname}" ] && success
	    [ -w "${fname}" ] && success
	    grep -q "uid=[0-9]*(${studuid})" "${fname}" && success
	    grep -q "gid=[0-9]*(${studgid})" "${fname}" && success
	fi
    fi
fi

# paragraph 5
wd="${basename}/${studname}/group"
if [ -d "${wd}" ] ; then
    success
    if [ -d "${wd}/dir_1" ] ; then
	success
	fname="${wd}/dir_1/file_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-r--r-----" ] && success
	    [[ "${amode}" =~ ^.r..r..... ]] && success
	fi
	fname="${wd}/dir_1/file_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-rw-rw----" ] && success
	    [[ "${amode}" =~ ^.rw.rw.... ]] && success
	fi
	fname="${wd}/dir_1/file_3"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-rwxr-x---" ] && success
	    [[ "${amode}" =~ ^.rwxr.x... ]] && success
	fi
    fi
    # paragraph 6
    if [ -d "${wd}/dir_2" ] ; then
	success
	fname="${wd}/dir_2/subdir_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "dr--rw----" ] && success
	    [[ "${amode}" =~ ^.r..rw.... ]] && success
	fi
	fname="${wd}/dir_2/subdir_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "drw-r-----" ] && success
	    [[ "${amode}" =~ ^.rw.r..... ]] && success
	fi
	fname="${wd}/dir_2/subdir_3"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "drwxr-x---" ] && success
	    [[ "${amode}" =~ ^.rwxr.x... ]] && success
	fi
    fi
    # paragraph 7
    if [ -d "${wd}/dir_3" ] ; then
	success
	fname="${wd}/dir_3/file_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    [ "${studuid}" != "${uid}" ] && success
	    [ "${studgid}" != "${gid}" ] && success
	    [ -f "${fname}" ] && success
	fi
	fname="${wd}/dir_3/file_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-rw-rw----" ] && success
	    [[ "${amode}" =~ ^.rw.rw.... ]] && success
	    # list of processes should contain at least 'ps' and 'bash'
	    # Proper process line should have PID
	    pid=`grep -w bash "${fname}" | awk '{print $1}'`
	    [[ "${pid}" =~ [1-9][0-9]* ]] && success
	    pid=`grep -w ps "${fname}" | awk '{print $1}'`
	    [[ "${pid}" =~ [1-9][0-9]* ]] && success
	fi
    fi
fi

# paragraph 8
wd="${basename}/${studname}/others"
if [ -d "${wd}" ] ; then
    success
    if [ -d "${wd}/dir_1" ] ; then
	success
	fname="${wd}/dir_1/file_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-r--r--r--" ] && success
	    [[ "${amode}" =~ ^.r..r..r.. ]] && success
	fi
	fname="${wd}/dir_1/file_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-rw-r--rwx" ] && success
	    [[ "${amode}" =~ ^.rw.r..rwx ]] && success
	fi
    fi
    # paragraph 9
    if [ -d "${wd}/dir_2" ] ; then
	success
	fname="${wd}/dir_2/subdir_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "dr--rw-r--" ] && success
	    [[ "${amode}" =~ ^.r..rw.r.. ]] && success
	fi
	fname="${wd}/dir_2/subdir_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "drw-r--r-x" ] && success
	    [[ "${amode}" =~ ^.rw.r..r.x ]] && success
	fi
	fname="${wd}/dir_2/subdir_3"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "drwxr-xrw-" ] && success
	    [[ "${amode}" =~ ^.rwxr.xrw. ]] && success
	fi
    fi
    # paragraph 10
    if [ -d "${wd}/dir_3" ] ; then
	success
	fname="${wd}/dir_3/file_1"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    # is it a symbolic link?
	    if [ -L "${fname}" ] ; then
		success
		# file_1 -> file_2
		if ls -l "${fname}" | grep -q -- "-> file_2" ; then
		    success
		else # or file_1 -> somepath/file_2
		    # symbolic link points to the proper file
		    inode1=`ls -i $(readlink "${fname}") | awk '{print $1}'`
		    inode2=`ls -i "${wd}/dir_3/file_2"   | awk '{print $1}'`
		    [ "${inode1}" = "${inode2}" ] && success
		fi
	    fi
	fi
	fname="${wd}/dir_3/file_2"
	if [ -e "${fname}" ] ; then
	    success
	    uid=`stat --format "%U" "${fname}"`
	    gid=`stat --format "%G" "${fname}"`
	    amode=`stat --format "%A" "${fname}"`
	    [ "${studuid}" = "${uid}" ] && success
	    [ "${studgid}" = "${gid}" ] && success
	    [ "${amode}" =   "-rwxrwxrwx" ] && success
	    [[ "${amode}" =~ ^.rwxrwxrwx ]] && success
	    # list of files in current directory should include:
	    # 1) symbolic link of file_1 to file_2
	    grep -q '^l.* -> ' "${fname}" && success
	    # 2) file itself
	    grep -q '^-.*file_2' "${fname}" && success
	fi
    fi
fi

final

# End of file
