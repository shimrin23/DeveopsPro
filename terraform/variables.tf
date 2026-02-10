variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-south-1"  # Mumbai region (your current setup)
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "salon-booking"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"  # Suitable for Jenkins + Docker
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "salon-key"  # Your existing key
}

variable "allowed_ssh_ips" {
  description = "IP addresses allowed to SSH (your IP)"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # CHANGE THIS to your IP for security
}

variable "mongo_username" {
  description = "MongoDB username"
  type        = string
  default     = "smrn"
  sensitive   = true
}

variable "mongo_password" {
  description = "MongoDB password"
  type        = string
  default     = "201114"
  sensitive   = true
}

variable "enable_jenkins" {
  description = "Create separate Jenkins server"
  type        = bool
  default     = true
}

variable "enable_monitoring" {
  description = "Enable CloudWatch monitoring"
  type        = bool
  default     = true
}
