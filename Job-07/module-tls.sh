#!/bin/bash

# This file is the installation file for the TLS protocol


sudo apt install openssl

# Create key and certificate for a duration of 1 year
sudo mkdir /etc/proftpd/ssl
sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/proftpd.crt -keyout /etc/ssl/private/proftpd.key


sudo chmod 640 /etc/ssl/private/proftpd.key
sudo chmod 640 /etc/ssl/certs/proftpd.crt


# Activate the tls.conf file
line=$(sudo sed -n '/Include \/etc\/proftpd\/tls.conf/=' $proftpdconfigPath)
sudo sed -i "${line}s/.//" $proftpdconfigPath

# Settings on tls.conf file
line=$(sudo sed -n '/TLSEngine/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/TLSLog/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/TLSProtocol/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/TLSRSACertificateFile/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/TLSRSACertificateKeyFile/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/AllowClientRenegotiations/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/TLSVerifyClient/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/TLSRequired/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath

line=$(sudo sed -n '/TLSRenegotiate/=' $tlsconfigPath)
sudo sed -i "${line}s/.//" $tlsconfigPath 


# Activate the TLS module in the modules configuration file
line=$(sudo sed -n '/LoadModule mod_tls.c/=' $modulesconfigPath)
sudo sed -i "${line}s/.//" $modulesconfigPath 
line=$(sudo sed -n '/LoadModule mod_tls_fscache.c/=' $modulesconfigPath)
sudo sed -i "${line}s/.//" $modulesconfigPath 
line=$(sudo sed -n '/LoadModule mod_tls_shmcache.c/=' $modulesconfigPath)
sudo sed -i "${line}s/.//" $modulesconfigPath 



if sudo systemctl restart proftpd ; then
    echo "========================="
    echo "TLS INSTALLATION COMPLETE"
else
    echo "THERE IS A PROBLEM WITH TLS PROTOCOL" && exit
fi


