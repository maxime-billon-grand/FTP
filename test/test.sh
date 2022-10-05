#!/bin/bash

proftpdconfigPath="../test/proftpd.conf"


# Creation of the users
echo ">> Creation of the FTP user(s) :"
echo "Type the connexion username : (the username will be converted to lowercase)"
read username
echo "Type the password of the user:"
read password

#sudo adduser ${username,,} --gecos ",,,," --disabled-password
#echo "${username,,}:$password" | sudo chpasswd
    echo "the username is ${username,,} and password is $password"


echo "Do you want to create another user ? (Y/N)"
read moreUsers

until [[ "$moreUsers" == "N" ]] || [[ "$moreUsers" == "n" ]]
do
    echo "Type the connexion username : (the username will be converted to lowercase)"
    read username
    echo "Type the password of the user:"
    read password

#    sudo adduser ${username,,} --gecos ",,,," --disabled-password
#    echo "${username,,}:$password" | sudo chpasswd

    echo "the username is ${username,,} and password is $password"

    echo "Do you want to create another user ? (Y/N)"
    read moreUsers

done



