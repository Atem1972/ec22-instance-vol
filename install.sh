#!/bin/bash

# Update the system and install dependencies
sudo yum update -y

# Install Apache HTTP Server (httpd)
sudo yum install -y httpd

# Enable httpd to start on boot and start the service
sudo systemctl enable httpd
sudo systemctl start httpd

# Install Docker
sudo amazon-linux-extras install docker -y

# Enable Docker to start on boot and start the Docker service
sudo systemctl enable docker.service
sudo systemctl start docker

# Add the ec2-user to the docker group so you can run docker commands without sudo
sudo usermod -aG docker ec2-user
sudo chmod 666 /var/run/docker.sock
# Verify installations
sudo systemctl status httpd
sudo systemctl status docker