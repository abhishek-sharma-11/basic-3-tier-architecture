#!/bin/bash
sudo yum update -y
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo systemctl enable nginx
sudo systemctl start nginx