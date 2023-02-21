#!/bin/bash
apt update -y
apt-get install mysql-server -y
apt-get install sed -y
sed -i 's/127.0.0.1/0.0.0.0/g' "/etc/mysql/mysql.conf.d/mysqld.cnf"
mysql -e "CREATE USER 'mieulet'@'%' IDENTIFIED WITH mysql_native_password BY 'TestUbuntu123@';"
mysql -e "GRANT PRIVILEGE ON *.* TO 'mieulet'@'%';"
mysql -e "FLUSH PRIVILEGES;"
systemctl restart mysql