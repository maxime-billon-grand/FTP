#!/bin/bash


proftpdconfigPath="../test/proftpd.conf"

# Uncomment the lines in proftpd.conf for Anonymous access
lineStart=$(sed -n '/<Anonymous ~ftp>/=' $proftpdconfigPath)
echo $lineStart

lineStop=$(sed -n "/<\/Anonymous>/=" $proftpdconfigPath)
echo $lineStop

for (( i=$lineStart; i<=$lineStop; i++ )); do
    sed -i "${i}s/.//" $proftpdconfigPath
done




