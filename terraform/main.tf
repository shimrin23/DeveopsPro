provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "simple_sg" {
  name        = "simple-server-sg"
  description = "Allow SSH and Web traffic"

  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows connection from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_server" {
  ami           = "ami-080e1f13689e07408" 
  
  instance_type = "t3.micro"

  key_name      = "simple-key"

  # SECURITY: Attaching the firewall we created above
  vpc_security_group_ids = [aws_security_group.simple_sg.id]

  tags = {
    Name = "My-Simple-Server"
  }
}

output "server_ip" {
  value = aws_instance.my_server.public_ip
}