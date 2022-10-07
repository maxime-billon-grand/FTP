#!/bin/bash

# Path of this script
thisPath=$(dirname "$0")

# Archive file name
dateSysteme=$(date +%d-%m-%Y-%H:%M)
folderName="Backup_"$dateSysteme

# Create the folders
mkdir $thisPath/$folderName
mkdir $thisPath/$folderName/homes
mkdir $thisPath/$folderName/logs


# Copy of the proftpd configuration directory and logs files
sudo cp -t  $thisPath/$folderName -r /etc/proftpd/
sudo cp /var/log/proftpd/* $thisPath/$folderName/logs

# Copy of the FTP user's homes
echo "Which FTP user's home directory do you want to save ?"
read -p "(Type the username):" username
sudo cp -t $thisPath/$folderName/homes -r /home/${username,,}

echo "Do you want to save another user ? (Y/N)"
read moreUsers

until [[ "$moreUsers" == "N" ]] || [[ "$moreUsers" == "n" ]]
do
    read -p "(Type the username):" username
    sudo cp -t $thisPath/$folderName/homes -r /home/${username,,}

    echo "Do you want to save another user ? (Y/N)"
    read moreUsers

done

# Give me the rights of all the saving file
sudo chown -R max:max $thisPath/$folderName
sudo chmod -R 755 $thisPath/$folderName

cd $thisPath
tar --force-local -czf $folderName.tar.gz $folderName --remove-files

<<Block_comment
# > To send the file to another machine via ftps :
ftp-ssl <ip address>
# connect to this machine via login & password
# > Go to the local repertory where the backup file is located with command "lcd /path/to/file""
# > Go to the distant repertory where you want to put this backup file with the command "cd /destination/ path"
# > Transfer the backup file with the command :
put Backup_dd-mm-yyyy-HH:MM.tar.gz
Block_comment
