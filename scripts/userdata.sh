#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "<center><h1>Hello world!</h1></center>" >> /var/www/html/index.html
# Install cloudwatch agent and send logs to the cloudwatch log group
sudo yum install awslogs -y
sudo sed -i "s/.*region = us-east-1/region = eu-west-1/g" /etc/awslogs/awscli.conf
sudo sed -i "s/.*file = \/var\/log\/messages/file = \/var\/log\/httpd\/access_log/g" /etc/awslogs/awslogs.conf
sudo service awslogsd start
sudo systemctl  enable awslogsd