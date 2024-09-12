#!/bin/bash
set -e

sudo apt update -y
sudo apt install nginx -y

sudo systemctl enable nginx
sudo systemctl start nginx

# Get the hostname of the instance
HOSTNAME=$(hostname)

# Create the index.html file with the hostname
echo "<html>
<head>
  <title>EC2 Instance</title>
</head>
<body>
  <h1>Welcome to the EC2 instance: $HOSTNAME</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Create a file for the load balancer health check in Nginx
echo "server {
    listen 80;
    server_name localhost;

    location / {
        root /var/www/html;
        index index.html index.htm;
    }

    location /health {
        access_log off;
        return 200 'healthy';
        add_header Content-Type text/plain;
    }
}" | sudo tee /etc/nginx/sites-available/default

# Restart Nginx to apply the changes
sudo systemctl restart nginx
