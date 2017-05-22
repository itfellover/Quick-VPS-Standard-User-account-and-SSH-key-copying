#!/bin/bash

echo '
      This script will create a new standard user account, copy your current root ssh authorized key file to the new standard user account
      and then stop you or anyone else from logging in as root in the future. Only your newly created user account will be allowed to login
      in future  with sudo privileges. This also disables exim4 and rpcbind from loading and being accessible on your system over the Internet.
      If you run 'netstat -tulpn' from your system before running this script you can see if there is any other ports open that you want to block
      and add them to this script before running it to block them all. Reboot your system on completion to allow the changes to take effect.

        1 - Update the system and install fail2ban to block incoming ssh connections
        2 - Enter a standard username
        3 - Create the standard account without a password
        4 - Allocate sudo privleges to your newly created account
        5 - Copy your authorized_keys file from your root account to your new standard account
        6 - Set PermitRootLogin to no so root can no longer login
        7 - Set your standard user to be the only account to login over ssh
        8 - Disable exim4 and rpcbind from listening on your system
        9 - Enter a password for your standard user account
        10 - Reboot your system manually so the services are fully disabled


                                                        Created by ITFellover
                                                      https://www.itfellover.com
                                          +-+-+-+-+-+ +-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
                                          |P|r|e|s|s| |E|N|T|E|R| |t|o| |c|o|n|t|i|n|u|e|
                                          +-+-+-+-+-+ +-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

'

read -p ""

sudo apt-get update && apt-get upgrade -y && apt-get install fail2ban screen -y

echo "Please enter a username for your standard user that will be created"
read Username

echo "Creating the standard user account with no password"
sudo adduser --disabled-password --gecos "" "$Username"

usermod -aG sudo "$Username"

mkdir /home/"$Username"/.ssh
sudo cat /root/.ssh/authorized_keys > /home/"$Username"/.ssh/authorized_keys
chmod 700 /home/"$Username"/.ssh
chmod 600 /home/"$Username"/.ssh/authorized_keys
chown -R "$Username":"$Username" /home/"$Username"/
sudo sed -i 's|PermitRootLogin yes|PermitRootLogin no|g' /etc/ssh/sshd_config
sudo sed -i '1i# Allow only this user to access the server\nAllowUsers '"$Username"'' /etc/ssh/sshd_config
sudo update-rc.d -f exim4 disable
sudo update-rc.d -f rpcbind disable
sudo systemctl reload sshd

echo "Please enter a password for your newly created user so you can use sudo"
passwd "$Username"

echo "Make sure to reboot your system!"

