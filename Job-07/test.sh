#!/bin/bash

proftpdconfigPath="../test/tls.conf"

line=$(sed -n '/AllowClientRenegotiations/=' $proftpdconfigPath)

echo $line
