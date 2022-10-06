#!/bin/bash

# Path of this script
thisPath=$(dirname "$0")
csvfile=$thisPath/FTP_Userlist.csv


# Add /bin/false in /etc/shells if not already present
if grep -q "/bin/false" /etc/shells; then
    echo "The shell /bin/false already present in /etc/shells"
else
    sudo printf "/bin/false" | sudo tee -a /etc/shells
fi

# Create ftpgroup if doesn't exist
if grep -q "ftpgroup" /etc/group; then
    echo "The ftpgroup already exists"
else
    echo "The ftpgroup doesn't exist, creating ..."
    sudo adduser --group ftpgroup
fi


# Give auth to only the members of the ftpgroup in the new config file conf.d/users.conf
if test -e /etc/proftpd/conf.d/users.conf; then
    echo "The file users.conf in conf.d repertory already exists"
else
    sudo touch /etc/proftpd/conf.d/users.conf
    echo -e "<Limit ALL>\n DenyGroup !ftpgroup\n</Limit>\n" | sudo tee /etc/proftpd/conf.d/users.conf
fi

# Put each lin in an array $line {ID Prénom Nom Mdp Role}
while IFS=, read -ra line
do

# Treat only lines with ID greater than 1000
    if [[ ${line[0]} =~ '^[0-9]+$' ]] & [[ ${line[0]} -gt 1000 ]]; then

# Execute only if user doesn't already exist
        if ! id -u "${line[1],,}" >/dev/null 2>&1; then
            echo "USER DOESN'T EXISTS" ${line[1]} ${line[2]}

# Create the user in the group ftpgroup, his /home, without shell
            sudo adduser ${line[1],,} --gecos "${line[1]} ${line[2]},,," --disabled-password --ingroup ftpgroup --shell /bin/false --home /home/"${line[1],,}"
            echo "${line[1],,}:${line[3]}" | sudo chpasswd

# Add restrictions on the new user's /home directory
            echo -e "<Directory /home/${line[1],,}>\n Umask 022\n AllowOverwrite off \n <Limit LOGIN>\n  AllowUser ${line[1],,}\n  DenyAll\n </Limit> \n <Limit ALL>\n  AllowUser ${line[1],,}\n  DenyAll\n </Limit>\n</Directory>" | sudo tee -a /etc/proftpd/conf.d/users.conf


# If Admin, add to the sudo group
            if [[ ${line[4]} = "Admin" ]]; then
                echo ${line[1]} "IS AN ADMIN"
                sudo adduser ${line[1],,} sudo
            else
                echo ${line[1]} "IS NOT ADMIN"

            fi

# If user already exists
        else 
            echo "USER" ${line[1],,} "ALREADY EXISTS"

        fi
    
    else 
        echo "ID -> ${line[0]} is not correct"
    fi
done < $csvfile

if sudo systemctl restart proftpd ; then
    echo "========================="
    echo "USERS CREATION COMPLETE"
else
    echo "THERE IS A PROBLEM WITH PROFTPD" && exit
fi
