#!/bin/bash

#PackageLinux
yum update -y
yum install httpd -y
yum install git -y
yum install -y certbot python3-certbot-apache
service httpd start
chkconfig httpd on

#ConfigCustomApache
cd /var/www/html
echo "Hello!" > index.html

#RepostaticWeb
git clone https://github.com/roxsross/devops-practice-tools.git
cp -r devops-practice-tools/static-website/coming-soon-static-web/* /var/www/html/



#!/bin/bash
yum update -y

yum install -y mysql
yum -y install telnet
yum install -y httpd
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2

cd /var/www/html
wget https://wordpress.org/latest.tar.gz 
tar -xzf latest.tar.gz
sudo cp -r wordpress/*  /var/www/html/

chmod -R 755 wp-content
chown -R apache:apache wp-content

service httpd start
chkconfig httpd on



# Reference LAB
# https://aws.amazon.com/es/getting-started/hands-on/deploy-wordpress-with-amazon-rds/5/
