#!/bin/bash
until ping -c1 8.8.8.8 &>/dev/null; do :; done
sudo yum update -y
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd