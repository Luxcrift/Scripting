#!/bin/bash
apt update
apt install -y wget curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-6.gpg
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse"
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
dpkg -i ./libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
apt update
apt install -y mongodb-org
sed -i 's/127.0.0.1/0.0.0.0/g' "/etc/mongod.conf"
systemctl restart mongod