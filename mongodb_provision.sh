#!/bin/bash

echo "############ Uninstall old mongodb ##########"

sudo service mongod stop
sudo apt-get purge mongodb-org* -y
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb

echo "############################################"


echo "############# -START- #################"

echo "############ Step 1 ##########"
echo "Importing the Public Key, Adding the MongoDB Repository ..."
echo "##############################"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

echo "############ Step 2 ##########"
echo "Creating source list file MongoDB ..."
echo "##############################"

echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list

echo "############ Step 3 ##########"
echo "Updating the repository ..."
echo "##############################"

sudo apt-get update

echo "############ Step 4 ##########"
echo "Installing MongoDB ..."
echo "##############################"

sudo apt-get install -y mongodb-org

echo "############ Step 5 ##########"
echo "Update the systemd service ..."
echo "##############################"

sudo systemctl daemon-reload

echo "############ Step 6 ##########"
echo "Start the newly created service with systemctl ..."
echo "##############################"

sudo systemctl start mongod

echo "############ Step 6 ##########"
echo "Enabling automatic start of MongoDB when the system starts ..."
echo "##############################"

sudo systemctl enable mongod

echo "############ Step 7 ##########"
echo "Verifying MongoDB status ..."
echo "##############################"

sudo systemctl status mongod

echo "############# -END- #################"


