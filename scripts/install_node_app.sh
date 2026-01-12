#!/bin/bash
set -e
exec > /var/log/startup.log 2>&1

echo "Stopping default web servers"
systemctl stop nginx || true
systemctl disable nginx || true
systemctl stop apache2 || true
systemctl disable apache2 || true

echo "Installing Node.js"
apt-get update -y
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs git

echo "Installing PM2"
npm install -g pm2

echo "Fetching Node.js app"
mkdir -p /opt/node-app
cd /opt/node-app

git clone https://github.com/Poison-Iveey/sample-node-app.git .

echo "Installing dependencies"
npm install

echo "Starting Node app"
pm2 start index.js --name node-app
pm2 save
