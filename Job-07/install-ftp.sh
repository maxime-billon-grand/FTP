#!/bin/bash



# ProFTPd Installation
if ! sudo apt install proftpd-core ; then
    exit 
else
    echo "============================="
    echo "PROFTPD INSTALLATION COMPLETE"
fi

# Creation of the users
echo ">> Creation of the FTP user(s) :"
echo "Type the connexion username : (the username will be converted to lowercase)"
read username
echo "Type the password of the user:"
read password

sudo adduser ${username,,} --gecos ",,,," --disabled-password
echo "${username,,}:$password" | sudo chpasswd

echo "Do you want to create another user ? (Y/N)"
read moreUsers

until [[ "$moreUsers" == "N" ]] || [[ "$moreUsers" == "n" ]]
do
    echo "Type the connexion username : (the username will be converted to lowercase)"
    read username
    echo "Type the password of the user:"
    read password

    sudo adduser ${username,,} --gecos ",,,," --disabled-password
    echo "${username,,}:$password" | sudo chpasswd

    echo "Do you want to create another user ? (Y/N)"
    read moreUsers

done


# Path of the proFTPd configuration file
proftpdconfigPath="../test/proftpd.conf"
tlsconfigPath="../test/tls.conf"


# Jailing users in their /home folder
echo ">> Do you want to jail users in their /home directory ? (Y/N)"
read jail
if [[ "$jail" = "Y" ]] || [[ "$jail" = "y" ]]; then
    sed -i 's/# DefaultRoot~/DefaultRoot ~/' $proftpdconfigPath
fi


# Install of the Anonymous access
echo "================================================="
echo ">> DO YOU WANT TO CREATE ANONYMOUS ACCESS ? (Y/N)"
read installAnonymous


until [[ "$installAnonymous" == "Y" ]] || [[ "$installAnonymous" == "y" ]] || [[ "$installAnonymous" == "N" ]] || [[ "$installAnonymous" == "n" ]]
do
    echo "This is not the expected answer (Y/N)"
    read installAnonymous

done

if [ "$installAnonymous" = "Y" ] || [ "$installAnonymous" = "y" ]; then
    source ./module-anonymous.sh
fi


# Install of TLS protocol
echo "====================================="
echo ">> DO YOU WANT TO INSTALL TLS ? (Y/N)"
read installTLS

until [[ "$installTLS" == "Y" ]] || [[ "$installTLS" == "y" ]] || [[ "$installTLS" == "N" ]] || [[ "$installTLS" == "n" ]]
do
    echo "This is not the expected answer (Y/N)"
    read installTLS

done

if [ "$installTLS" = "Y" ] || [ "$installTLS" = "y" ]; then
    source ./module-tls.sh
fi



