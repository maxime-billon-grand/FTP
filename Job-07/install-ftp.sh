#!/bin/bash



# ProFTPd Installation
if ! sudo apt install proftpd-core ; then
    exit 
else
    echo "=============================="
    echo "PROFTPD INSTALLATION COMPLETE"
fi

# Path of the proFTPd configuration file
proftpdconfigPath="../test/proftpd.conf"
tlsconfigPath="../test/tls.conf"

echo "=============================================="
echo "DO YOU WANT TO CREATE ANONYMOUS ACCESS ? (Y/N)"
read installAnonymous


until [[ "$installAnonymous" == "Y" ]] || [[ "$installAnonymous" == "y" ]] || [[ "$installAnonymous" == "N" ]] || [[ "$installAnonymous" == "n" ]]
do
    echo "This is not the expected answer"
    read installAnonymous

done

if [ "$installAnonymous" = "Y" ] || [ "$installAnonymous" = "y" ]; then
    source ./module-anonymous.sh
fi




echo "=================================="
echo "DO YOU WANT TO INSTALL TLS ? (Y/N)"
read installTLS

until [[ "$installTLS" == "Y" ]] || [[ "$installTLS" == "y" ]] || [[ "$installTLS" == "N" ]] || [[ "$installTLS" == "n" ]]
do
    echo "This is not the expected answer"
    read installTLS

done

if [ "$installTLS" = "Y" ] || [ "$installTLS" = "y" ]; then
    source ./module-tls.sh
fi



