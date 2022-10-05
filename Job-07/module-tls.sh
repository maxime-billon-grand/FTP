#!/bin/bash


proftpdconfigPath="../test/proftpd.conf"
tlsconfigPath="../test/tls.conf"
modulesconfigPath="../test/modules.conf"

sudo apt install openssl
sudo apt install proftpd-mod-crypto

# Create key and certificate for a duration of 1 year
sudo mkdir /etc/proftpd/ssl
sudo openssl req -x509 -newkey rsa:1024 -keyout /etc/ssl/private/proftpd.key -out /etc/ssl/certs/proftpd.crt -nodes -days 365
# RENSEIGNEMENTS !!!!!!!

sudo chmod 640 /etc/ssl/private/proftpd.key
sudo chmod 640 /etc/ssl/certs/proftpd.crt


# Activate the tls.conf file
line=$(sed -n '/Include \/etc\/proftpd\/tls.conf/=' $proftpdconfigPath)
sed -i "${line}s/.//" $proftpdconfigPath

# Settings on tls.conf file
line=$(sed -n '/TLSEngine/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/TLSLog/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/TLSProtocol/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/TLSRSACertificateFile/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/TLSRSACertificateKeyFile/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/AllowClientRenegotiations/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/TLSVerifyClient/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/TLSRequired/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath

line=$(sed -n '/TLSRenegotiate/=' $tlsconfigPath)
sed -i "${line}s/.//" $tlsconfigPath 


# Activate the TLS module in the modules configuration file
line=$(sed -n '/LoadModule mod_tls.c/=' $modulesconfigPath)
sed -i "${line}s/.//" $modulesconfigPath 
line=$(sed -n '/LoadModule mod_tls_fscache.c/=' $modulesconfigPath)
sed -i "${line}s/.//" $modulesconfigPath 
line=$(sed -n '/LoadModule mod_tls_shmcache.c/=' $modulesconfigPath)
sed -i "${line}s/.//" $modulesconfigPath 





