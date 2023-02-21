#!/bin/bash
DOMAIN=$(curl icanhazip.com)
SSLIP="$DOMAIN.sslip.io"
sudo mv jenkins /etc/nginx/sites-available/
sudo apt update -y
sudo apt install -y wget unzip nginx
sudo systemctl start nginx
sudo mkdir -p /var/www/jenkins/html
sudo chown -R $USER:$USER /var/www/jenkins/html
sudo chmod -R 755 /var/www/jenkins
cat > jenkins <<EOF
server {
        listen 80;
        listen [::]:80;
        root /var/www/jenkins/html;
        index index.html index.htm index.nginx-debian.html;
        server_name $SSLIP www.$SSLIP;
        location / {
                #try_files $uri $uri/ =404;
                proxy_pass    http://$SSLIP:8080;
                proxy_read_timeout  90s;
        }
}
EOF
sudo mv jenkins /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
sudo systemctl restart nginx
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx --register-unsafely-without-email --agree-tos -d "${SSLIP}" --cert-name jenkins
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install -y default-jre
sudo apt install -y jenkins 
sudo systemctl start jenkins.service


Configurando jenkins
cagrar cred aws
manage cred - system - global cred - add cred

plugins - s3 publisher / aws global config / 

Token Github: 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
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN
AWS_REGION us-east-1

Crear Bucket como jenkins-mieulet y la instancia como S3-jenkins-web
## no es necesario colocarlo, en el pipeline selecciona la opcion "Pipeline script from SCM, y tila la opcion GitHub hook trigger"
web github https://github.com/Luxcrift/desafio3-despliegue2.git
Branch: main

pipeline {
    agent any

    stages {
        stage('AWS STS') {
            steps {
                echo 'AWS STS'
                sh 'aws sts get-caller-identity'
            }
        }
        stage('AWS S3 listar') {
            steps {
                sh 'aws s3 ls'
            }
        }
        stage('Git Clone') {
            steps {
                sh 'rm -rf S3-jenkins-web/'
                sh 'git clone https://github.com/Luxcrift/S3-jenkins-web.git'
                sh 'ls -lrt S3-jenkins-web/'
            }
        }
         stage('Upload to S3') {
            steps {
                sh 'aws s3 cp S3-jenkins-web s3://jenkins-mieulet --recursive'
            }
        }
    }
}