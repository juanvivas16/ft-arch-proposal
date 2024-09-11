#!/bin/bash

sudo apt update -y
sudo apt install nginx -y

sudo systemctl enable nginx
sudo systemctl start nginx

# Obtener el hostname de la instancia
HOSTNAME=$(hostname)

# Crear el archivo index.html con el hostname
echo "<html>
<head>
  <title>EC2 Instance</title>
</head>
<body>
  <h1>Welcome to the EC2 instance: $HOSTNAME</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Crear un archivo para el health check en Nginx
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

# Reiniciar Nginx para aplicar los cambios
sudo systemctl restart nginx