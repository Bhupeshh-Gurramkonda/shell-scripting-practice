#/bin/bash

#checking the user is having the superuser permission or not.
userid=$(id -u)

R= echo -e "\e[31m"
G= echo -e "\e[32m"
Y= echo -e "\e[33m"
W= echo -e "\e[0m"

if [ $userid -eq 0 ]
then
    echo " $G the user  having superuser permission to run script $W."
else
    echo " $R the user doesn't have superuser permission to run script $W."
    exit 1
fi 



packageinstalling(){
    dnf install $1 -y
    if [ $? -eq 0 ]
    then
        echo " $G the package $1 has been installed successfully $W."
    else
        echo "$R the package installation has been failed. Please check the package name once $W."
        exit 1
    fi
}

packagevalidate(){
    if [ $? -eq 0 ]
    then
        echo " $Y package $2 is already installed $W."
        exit 1
    else
        echo " $R package is not installed need to be install $W."
        packageinstalling $2
    fi
}

dnf list installed mysql
packagevalidate $? mysql
