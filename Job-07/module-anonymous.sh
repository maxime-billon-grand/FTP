#!/bin/bash

# This file is the installation file of the Anonymous access


# Uncomment the lines in proftpd.conf
lineStart=$(sudo sed -n '/<Anonymous ~ftp>/=' $proftpdconfigPath)

lineStop=$(sudo sed -n "/<\/Anonymous>/=" $proftpdconfigPath)

for (( i=$lineStart; i<=$lineStop; i++ )); do
    sudo sed -i "${i}s/.//" $proftpdconfigPath
done

# Autorise connexion without password
sudo sed -i "/DirFakeGroup/a AnonRequirePassword off" $proftpdconfigPath


if sudo systemctl restart proftpd ; then
    echo "======================================"
    echo "ANONYMOUS ACCESS INSTALLATION COMPLETE" 
else
    echo "THERE IS A PROBLEM WITH ANONYMOUS ACCESS" && exit
fi

