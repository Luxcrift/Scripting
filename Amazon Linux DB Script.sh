#!/bin/bash
yum update -y
yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm
amazon-linux-extras install epel -y
yum -y install mysql-community-server
systemctl enable --now mysqld
temp_password=$(grep password /var/log/mysqld.log | awk '{print $NF}')
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'TestCentos123@'; flush privileges;" > reset_pass.sql
mysql -u root --password="$temp_password" --connect-expired-password < reset_pass.sql
mysql -u root --password="TestCentos123@" -e "CREATE USER 'mieulet'@'%' IDENTIFIED BY 'TestCentos123@'; GRANT ALL PRIVILEGES ON *.* TO 'mieulet'@'%'; FLUSH PRIVILEGES;"