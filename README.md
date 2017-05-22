# Quick-VPS-Standard-User-account-and-SSH-key-copying
This script allows you to quickly configure a new VPS with a standard user account and locks out root logons. Further hardening will be required, this will get you started though.

This works perfectly with Digital Ocean, other VPS's may require additional services to be disabled. Check netstat -tulpn to find out what may be running. 

This has been tested and works with Debian 8.8 x64 YMMV with other OS's.

Installing:
sudo apt-get install git

git clone https://github.com/itfellover/Quick-VPS-Standard-User-account-and-SSH-key-copying.git

cd Quick-VPS-Standard-User-account-and-SSH-key-copying/

chmod +x VPS_Standard_Account.sh

./VPS_Standard_Account.sh
