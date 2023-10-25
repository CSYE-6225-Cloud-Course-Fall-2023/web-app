#!/bin/bash


# Specify the path to the zip file
ZIP_FILE="/tmp/Yuvaraj_dalavai_002789615_03.zip"

# Specify the destination directory for extraction
DEST_DIR="/opt/"

# Update the package list to get the latest package information
sudo apt-get update

sudo apt-get upgrade -y

# Install Node.js and npm
sudo apt-get install -y nodejs npm

# Install MariaDB
sudo apt-get install -y mariadb-server

# Install unzip
sudo apt-get install -y unzip

# Start and enable MariaDB service
sudo systemctl start mariadb
sudo systemctl enable mariadb


# Unzip the file to the destination directory
sudo unzip "$ZIP_FILE" -d "$DEST_DIR"

sudo chmod 655 "/opt"

cd /opt/

sudo npm install

sudo apt-get clean


