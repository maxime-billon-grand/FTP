#!/bin/bash

echo "THIS WILL REMOVE PROFTPD AND ALL ITS DEPENDENCIES FROM THIS MACHINE\nARE YOU SURE YOU WANT TO CONTINUE ? (Y/N)"
read continue

if [[ "$continue" = "N" ]] || [[ "$continue" = "n" ]]; then
    exit
fi

sudo systemctl kill proftpd.service

sudo apt-get remove proftpd*
sudo apt-get remove openssl

sudo apt-get purge proftpd*
sudo apt-get purge openssl

<<Block_comment

# Deletion of the users
echo ">> Deletion of the FTP user(s) :"

echo "Do you want to remove an user ? (Y/N)"
read moreUsers

until [[ "$moreUsers" == "N" ]] || [[ "$moreUsers" == "n" ]]
do
    echo "Type the username : (the username will be converted to lowercase)"
    read username
    echo "Type the password of the user:"
    read password

    sudo deluser ${username,,} --remove-home

    echo "Do you want to create another user ? (Y/N)"
    read moreUsers

done

Block_comment

# Deletion of ftpgroup if exist
if grep -q "ftpgroup" /etc/group; then
    deluser --group ftpgroup
else
    echo "The ftpgroup doesn't exist"
fi
