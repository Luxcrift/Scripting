Crear Instancias AWS

crear instancia:

aws ec2 run-instances --image-id ami-08c40ec9ead489470 --instance-type t3.micro --key-name bootcamp --security-group-ids sg-00f5b4475524ddd4b --count 1  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=bootcamp-ec2-instance}]'

taggear instancia :

aws ec2 create-tags --resources i-0b0857eb7dc5ac3ca --tags Key=Name,Value=MyInstance

listar instancias

aws ec2 describe-instances


filtrar instancias

aws ec2 describe-instances --filters "Name=instance-type,Values=t3.medium" --query "Reservations[].Instances[].InstanceId"

terminar instancias:

aws ec2 terminate-instances --instance-ids i-024a88fe343d2b87d




amazon Linux User Data
#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y 
systemctl enable nginx
systemctl start nginx
