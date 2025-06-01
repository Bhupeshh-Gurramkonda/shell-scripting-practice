#/bin/bash

#checking the user is having the superuser permission or not.
userid=$(id -u)
sudo mkdir -p /var/log/shell-script_log

R="\e[31m" #red colour
G="\e[32m" #Green colour
Y="\e[33m" #Yellow colour
W="\e[0m"  #White colour

LogFolder=/var/log/shell-script_log
Logfile=$LogFolder/$(echo $0_$(date +%d%b).log)


if [ $userid -eq 0 ]
then
    echo -e "$G the user  having superuser permission to run script $W." >> $Logfile
else
    echo -e "$R the user doesn't have superuser permission to run script $W." | tee -a  $Logfile
    exit 1
fi 



packageinstalling(){
    dnf install $1 -y >> $Logfile
    if [ $? -eq 0 ]
    then
        echo -e "$G the package $1 has been installed successfully $W." >> $Logfile
    else
        echo -e "$R the package installation has been failed. Please check the package name once $W." >> $Logfile
        exit 1
    fi
}

packagevalidate(){
    if [ $? -eq 0 ]
    then
        echo -e "$Y package $2 is already installed $W." >> $Logfile
        exit 1
    else
        echo -e "$R package is not installed need to be install $W." >> $Logfile
        packageinstalling $2
    fi
}

dnf list installed mysql
packagevalidate $? mysql