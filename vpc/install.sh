#!/bin/bash

# Update & Upgrade | Install Golang & GoPhish
sudo add-apt-repository ppa:certbot/certbot
sudo apt update & sudo upgrade -y
sudo apt install golang-go unzip jq -y

# Install GoPhish
wget https://github.com/gophish/gophish/releases/download/v0.11.0/gophish-v0.11.0-linux-64bit.zip
sudo mkdir /opt/gophish
sudo unzip gophish-v0.11.0-linux-64bit.zip -d /opt/gophish

# Update Cloudflare
set -e
internet_ip="$(dig +short myip.opendns.com @resolver1.opendns.com -4)"

curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/bdeb407a4a822dfe7fe812fb128e4aaa/dns_records/f2dddf3d494e0b32f8138f9c01952100" \
	-H "X-Auth-Email: sfernandez@ironbox.com.ar" \
	-H "X-Auth-Key: xxxx" \
	-H "Content-Type: application/json" \
	--data "{\"type\":\"A\",\"name\":\"nexflix.ironbox.com.ar\",\"content\":\"$internet_ip\",\"ttl\":1,\"proxied\":false}" | jq

# Install Certbot
sudo apt-get install python-certbot-apache -y
sudo certbot --apache -d nexflix.ironbox.com.ar --register-unsafely-without-email --agree-tos -n

# Copy Cert's
sudo cp /etc/letsencrypt/live/nexflix.ironbox.com.ar/privkey.pem /opt/gophish/
sudo cp /etc/letsencrypt/live/nexflix.ironbox.com.ar/fullchain.pem /opt/gophish/

# Change Config Files
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /opt/gophish/config.json
sudo sed -i 's/80/443/g' /opt/gophish/config.json
sudo sed -i 's/gophish_admin.key/privkey.pem/g' /opt/gophish/config.json
sudo sed -i 's/example.key/privkey.pem/g' /opt/gophish/config.json
sudo sed -i 's/gophish_admin.crt/fullchain.pem/g' /opt/gophish/config.json
sudo sed -i 's/example.crt/fullchain.pem/g' /opt/gophish/config.json

# Stop Apache2. Apache was used to Validate the certificate.
sudo service apache2 stop

# Ejecutar GoPhish
cd /opt/gophish
sudo chmod +x gophish
sudo ./gophish

sudo certbot --nginx --agree-tos --redirect --uir --hsts --staple-ocsp --must-staple -d nexflix.ironbox.com.ar --email sfernandez@ironbox.com.ar