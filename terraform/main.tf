provider "aws" {
 region = "ap-south-1"
 }

resource "aws_security_group" "salon_booking_sg" {
  name        = "salon-booking-sg"
  description = "Security group for Salon Booking Fullstack"

  # Port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 80 (Frontend)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 5001 (Backend)
  ingress {
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 8080 (Jenkins)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 27017 (MongoDB - accessible for debugging)
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "all_in_one_server" {
  ami           = "ami-0e2c8ccd9e0369337" # Ubuntu 24.04 AMI (Check yours!)
  instance_type = "t2.medium"
  key_name      = "salon-key2" 
  vpc_security_group_ids = [aws_security_group.salon_booking_sg.id]

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "SalonBooking-AllInOne"
  }
}