#/bin/bash

#checking the user is having the superuser permission or not.
userid=$(id -u)

R= "\e[31m"
G= "\e[32m"
Y= "\e[33m"
W= "\e[0m"

if [ $userid -eq 0 ]
then
    echo -e "$G the user  having superuser permission to run script $W."
else
    echo -e "$R the user doesn't have superuser permission to run script $W."
    exit 1
fi 



packageinstalling(){
    dnf install $1 -y
    if [ $? -eq 0 ]
    then
        echo -e "$G the package $1 has been installed successfully $W."
    else
        echo -e "$R the package installation has been failed. Please check the package name once $W."
        exit 1
    fi
}

packagevalidate(){
    if [ $? -eq 0 ]
    then
        echo -e "$Y package $2 is already installed $W."
        exit 1
    else
        echo -e "$R package is not installed need to be install $W."
        packageinstalling $2
    fi
}

dnf list installed mysql
packagevalidate $? mysql
