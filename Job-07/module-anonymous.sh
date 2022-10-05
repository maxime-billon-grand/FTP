#!/bin/bash

# This file is the installation file of the Anonymous access

proftpdconfigPath="../test/proftpd.conf"

# Uncomment the lines in proftpd.conf
lineStart=$(sed -n '/<Anonymous ~ftp>/=' $proftpdconfigPath)
echo $lineStart

lineStop=$(sed -n "/<\/Anonymous>/=" $proftpdconfigPath)
echo $lineStop

for (( i=$lineStart; i<=$lineStop; i++ )); do
    sed -i "${i}s/.//" $proftpdconfigPath
done

# Autorise connexion without password
sed -i "/DirFakeGroup/a AnonRequirePassword off" $proftpdconfigPath


if sudo systemctl restart proftpd ; then
    echo "======================================"
    echo "ANONYMOUS ACCESS INSTALLATION COMPLETE" 
else
    echo "THERE IS A PROBLEM WITH ANONYMOUS ACCESS" && exit
fi

