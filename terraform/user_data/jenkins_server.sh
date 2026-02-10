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

# Run Jenkins in Docker
docker run -d \
  --name jenkins \
  --restart=always \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts

# Wait for Jenkins to start
sleep 60

# Get initial admin password
JENKINS_PASSWORD=$(docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword)

# Configure firewall
ufw allow 22/tcp
ufw allow 8080/tcp
ufw allow 50000/tcp
ufw --force enable

# Create info file
cat > /home/ubuntu/jenkins-info.txt <<EOF
Jenkins Installation Complete!
==============================

Jenkins URL: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8080

Initial Admin Password: $JENKINS_PASSWORD

Next Steps:
1. Open the Jenkins URL in your browser
2. Enter the initial admin password above
3. Install suggested plugins
4. Create your first admin user
5. Configure GitHub webhook: http://YOUR_JENKINS_IP:8080/github-webhook/

To view this info again: cat /home/ubuntu/jenkins-info.txt
To see Jenkins logs: docker logs jenkins
EOF

chown ubuntu:ubuntu /home/ubuntu/jenkins-info.txt

echo "Jenkins setup complete! Check /home/ubuntu/jenkins-info.txt for details"
