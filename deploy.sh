#!/bin/bash

# EC2 Deployment Script for Food Delivery Website
echo "🚀 Starting deployment process..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install apache2 git unzip -y

# Create project directory
sudo mkdir -p /var/www/html/food-delivery
cd /var/www/html/food-delivery

# Set proper permissions
sudo chown -R $USER:$USER /var/www/html/food-delivery
sudo chmod -R 755 /var/www/html/food-delivery

# Create directory structure
mkdir -p components scripts/components

echo "📁 Directory structure created"

# Start Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Configure Apache virtual host
sudo tee /etc/apache2/sites-available/food-delivery.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerName $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
    DocumentRoot /var/www/html/food-delivery
    
    <Directory /var/www/html/food-delivery>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog \${APACHE_LOG_DIR}/food-delivery_error.log
    CustomLog \${APACHE_LOG_DIR}/food-delivery_access.log combined
</VirtualHost>
EOF

# Enable site
sudo a2ensite food-delivery.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2

echo "✅ Apache configured successfully"
echo "🌐 Your website will be available at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
echo ""
echo "📋 Next steps:"
echo "1. Upload your website files to /var/www/html/food-delivery/"
echo "2. Set proper permissions: sudo chown -R www-data:www-data /var/www/html/food-delivery/"
echo "3. Test your website in the browser"