#!/bin/bash
## 批量创建用户

VAR_GROUPNAME="root"
#指定用户的所属组

VAR_USERNAME="user"
#用户名前缀

VAR_USERID="2001"
#用户的起始ID

MYDIR=`dirname $0`
>$MYDIR/$VAR_GROUPNAME.$VAR_USERNAME.txt

grep -E "^${VAR_GROUPNAME}:" /etc/group || groupadd $VAR_GROUPNAME

for i in ${VAR_USERNAME}{001..100}
do
	useradd $i -u $VAR_USERID -s /bin/bash -g $VAR_GROUPNAME -m
	
	VAR_PASSWORD=`echo $RANDOM+$RANDOM | md5sum | cut -c 1-8`
	
	echo $VAR_PASSWORD | passwd --stdin $i
	
	echo -e "${i}\t${VAR_PASSWORD}" >> $MYDIR/$VAR_GROUPNAME.$VAR_USERNAME.txt
	
	((VAR_USERID++))
done
