#!/bin/bash

#Shell Script to find the Largest file in the System and that are old file like 10 days.
#The script just compress that file and insert into Archive Folder.
#And run this script everyday using crontab helps to achive automation


#$Fri Jul 31 20:02:55 IST 2024$

#Variables
BASE = /home/Demo
DAYS = 10
DEPTH = 1
RUN = 0

#Check if the directory is present or not

if [ ! -d $BASE ]
then
        echo "directory doesnot exists"
        exit 1
fi

#Create 'archive' folder if not present

if [ ! -d $BASE/archive ]
then
        mkdir $BASE/archive
fi

#Find the list of files length more than 20MB

for i in `find $BASE -maxdepth $DEPTH -type f -size +20Mb`
do 
        if [ $RUN -eq 0 ]
        then
                echo "[$(date "+%Y-%m-%d %H:%M:%S")] archiving $i ==> $BASE/archive"
                gzip $i || exit 1
                mv $i.gz $BASE/archive || exit 1
        fi
done

#Commands to run this Script EveryDay Uaing crontab
# 05 01 * * * /home/Demo/Archive.sh