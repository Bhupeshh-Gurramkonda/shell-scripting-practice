#/bin/bash

#checking the user is having the superuser permission or not.
userid=$(id -u)
if [ $userid -eq 0 ]
then
    echo " the user  having superuser permission to run script."
else
    echo " the user doesn't have superuser permission to run script."
    exit 1
fi 



packageinstalling(){
    dnf install $2
    if[ $? -eq 0]
    then
        echo " the package $2 has been installed successfully."
    else
        echo " the package installation has been failed. Please check the package name once."
        exit 1
}

packagevalidate(){
    if [ $? -eq 0]
    then
        echo "package $2 is already installed."
        exit 1
    else
        echo "package is not installed need to be install."
        packageinstalling $2
    fi
}

dnf list installed mysql
packagevalidate $? mysql


