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

