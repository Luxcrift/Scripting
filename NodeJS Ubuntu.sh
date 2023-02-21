#!/bin/bash
apt update -y
apt install nginx -y
ufw allow http
ufw reload
apt install -y nodejs npm
git clone https://github.com/roxsross/bootcamp-ec2-challenge.git
cd bootcamp-ec2-challenge
npm install
cd
npm install pm2 -g
pm2 start bootcamp-ec2-challenge/index.js

#cat <<EOF >> /etc/nginx/sites-enabled/bootcamp
sudo echo 'server {' > /etc/nginx/sites-enabled/bootcamp
sudo echo 'listen        80;' > /etc/nginx/sites-enabled/bootcamp
    server_name _;
    location / {
        proxy_pass         http://35.171.169.64:8080;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection keep-alive;
        proxy_set_header   Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-enabled/bootcamp

systemctl restart nginx
touch /etc/nginx/sites-enabled/bootcamp


aws s3 cp C:\Users\Luxcrift\Fondo s3://bootcamp-mieulet/ --recursive --exclude ".git/*"