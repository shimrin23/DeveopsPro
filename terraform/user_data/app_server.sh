#!/bin/bash
set -e

# Update system
apt-get update
apt-get upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl enable docker
systemctl start docker

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Create application directory
mkdir -p /home/ubuntu/salon-booking
chown -R ubuntu:ubuntu /home/ubuntu/salon-booking

# Install monitoring tools
apt-get install -y htop curl wget git

# Configure firewall (UFW)
ufw allow 22/tcp
ufw allow 3000/tcp
ufw allow 5001/tcp
ufw allow 27017/tcp
ufw --force enable

echo "Application Server setup complete!"
echo "MongoDB Username: ${mongo_username}"
echo "Next steps:"
echo "1. Clone your repository"
echo "2. Update .env files"
echo "3. Run: docker-compose up -d"
