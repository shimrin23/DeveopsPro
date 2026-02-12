terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # N. Virginia
}

# --- 1. AUTOMATICALLY FIND LATEST UBUNTU 22.04 AMI ---
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Official Ubuntu Owner)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# --- 2. SECURITY GROUP (FIREWALL) ---
resource "aws_security_group" "salon_sg" {
  name        = "salon-booking-sg"
  description = "Allow SSH, HTTP, HTTPS, Jenkins, and SonarQube"

  # SSH (Port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP (Port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS (Port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins (Port 8080)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SonarQube (Port 9000 - Optional but good for DevOps)
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress (Allow all outgoing traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- 3. EC2 INSTANCE ---
resource "aws_instance" "all_in_one_server" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = "t2.micro"  # Free Tier Eligible
  key_name      = "salon-key" # Your existing key in N. Virginia

  vpc_security_group_ids = [aws_security_group.salon_sg.id]

  # --- STORAGE CONFIGURATION ---
  # Upgrade root volume to 25GB (Free tier allows 30GB total).
  # Default 8GB is too small for Docker/Jenkins images.
  root_block_device {
    volume_size = 25
    volume_type = "gp3"
    delete_on_termination = true
  }

  # --- USER DATA (Runs on First Boot) ---
  # Creates 4GB Swap Memory to prevent t2.micro from crashing
  user_data = <<-EOF
              #!/bin/bash
              fallocate -l 4G /swapfile
              chmod 600 /swapfile
              mkswap /swapfile
              swapon /swapfile
              echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
              EOF

  tags = {
    Name = "SalonBooking-AllInOne"
  }
}

# --- 4. OUTPUTS ---
output "server_public_ip" {
  description = "The public IP address of the server"
  value       = aws_instance.all_in_one_server.public_ip
}

output "ssh_command" {
  description = "Copy this command to connect"
  value       = "ssh -i salon-key.pem ubuntu@${aws_instance.all_in_one_server.public_ip}"
}