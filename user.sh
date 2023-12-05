#!/bin/bash


exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data script at $(date)"

# Sleep for a while to ensure that the instance is fully initialized
sleep 60

# Install and start Nginx
sudo amazon-linux-extras install -y nginx1
sudo service nginx start

echo "User data script completed at $(date)"