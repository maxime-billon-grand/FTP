#!/bin/bash

line=("1000" "Octavia" "Blake" "mdpo")

echo ${line[1],,}
echo ${line[2]}
echo ${line[3]}

<<Block_comment
line=("1000" "Octavia" "Blake" "mdpo")

echo ${line[1],,}
echo ${line[2]}
echo ${line[3]}

sudo adduser --group ftpgroup

# Create the user
sudo adduser ${line[1],,} --gecos "${line[1]} ${line[2]},,," --disabled-password --ingroup ftpgroup --shell /bin/false --home /home/"${line[1],,}"
echo "${line[1],,}:${line[3]}" | sudo chpasswd



if grep -q "ftpgroup" /etc/group; then
    echo "ftpgroup exists"
else
    echo "ftpgroup doesn't exist"
fi

sudo touch /etc/proftpd/conf.d/users.conf
echo -e "<Limit ALL>\n DenyGroup !ftpgroup\n</Limit>\n" | sudo tee /etc/proftpd/conf.d/users.conf

echo -e "<Directory /home/${line[1],,}>\n Umask 022\n AllowOverwrite off \n <Limit LOGIN>\n  AllowUser ${line[1],,}\n  DenyAll\n </Limit> \n <Limit ALL>\n  AllowUser ${line[1],,}\n  DenyAll\n </Limit>\n</Directory>" | sudo tee -a /etc/proftpd/conf.d/users.conf

Block_comment

if test -e /etc/proftpd/conf.d/users.conf; then
    echo "The file users.conf in conf.d repertory already exists"
else
    sudo touch /etc/proftpd/conf.d/users.conf
    echo -e "<Limit ALL>\n DenyGroup !ftpgroup\n</Limit>\n" | sudo tee /etc/proftpd/conf.d/users.conf
fi
