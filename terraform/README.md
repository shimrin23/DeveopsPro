# Terraform Infrastructure for Online Salon Booking

This Terraform configuration provisions AWS infrastructure for the Online Salon Booking application.

## 🏗️ What This Creates

### Resources Created:
1. **Application Server EC2** - Runs Docker containers (Frontend, Backend, MongoDB)
2. **Jenkins Server EC2** (optional) - CI/CD automation
3. **Security Groups** - Firewall rules for both servers
4. **Elastic IPs** - Static public IP addresses
5. **Auto-configured servers** - Docker and services installed automatically

### Ports Exposed:
- **3000** - Frontend React App
- **5001** - Backend API
- **27017** - MongoDB
- **8080** - Jenkins Web UI (if enabled)
- **22** - SSH Access

## 📋 Prerequisites

1. **AWS Account** with admin access
2. **AWS CLI** installed and configured
3. **Terraform** installed (v1.0+)
4. **EC2 Key Pair** created (salon-key)

## 🚀 Quick Start

### Step 1: Configure AWS Credentials
```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Region: ap-south-1
```

### Step 2: Prepare Variables
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

### Step 3: Initialize Terraform
```bash
terraform init
```

### Step 4: Review Plan
```bash
terraform plan
```

### Step 5: Apply Configuration
```bash
terraform apply
```

Type `yes` when prompted.

### Step 6: Get Outputs
```bash
terraform output
```

## 📝 Important Outputs

After `terraform apply`, you'll get:

```
app_server_public_ip = "13.233.207.130"
jenkins_server_public_ip = "13.234.XXX.XXX"
jenkins_url = "http://13.234.XXX.XXX:8080"
frontend_url = "http://13.233.207.130:3000"
backend_url = "http://13.233.207.130:5001"
ssh_command_app = "ssh -i salon-key.pem ubuntu@13.233.207.130"
ssh_command_jenkins = "ssh -i salon-key.pem ubuntu@13.234.XXX.XXX"
```

## 🔧 Post-Deployment Steps

### For Application Server:
```bash
# SSH into server
ssh -i salon-key.pem ubuntu@<APP_SERVER_IP>

# Clone repository
git clone https://github.com/YOUR_USERNAME/OnlineSalonBooking.git
cd OnlineSalonBooking

# Update frontend/.env.production with new IP
REACT_APP_SERVER_DOMAIN=http://<APP_SERVER_IP>:5001/api

# Deploy with Docker Compose
docker-compose up -d

# Check status
docker ps
```

### For Jenkins Server:
```bash
# SSH into Jenkins server
ssh -i salon-key.pem ubuntu@<JENKINS_SERVER_IP>

# Get Jenkins initial password
cat /home/ubuntu/jenkins-info.txt

# Access Jenkins at: http://<JENKINS_SERVER_IP>:8080
```

## 🔐 Security Best Practices

1. **Update `allowed_ssh_ips`** in terraform.tfvars to your IP only
2. **Change MongoDB password** from default
3. **Enable HTTPS** with SSL certificate
4. **Use AWS Secrets Manager** for sensitive data
5. **Enable VPC** for network isolation (advanced)

## 📊 Cost Estimation

- **t2.medium** × 2 = ~$60/month
- **EBS Storage** (30GB × 2) = ~$6/month
- **Data Transfer** = Variable
- **Total**: ~$70-100/month

## 🛠️ Common Commands

```bash
# View current state
terraform show

# List resources
terraform state list

# Destroy everything
terraform destroy

# Update specific resource
terraform apply -target=aws_instance.app_server

# Format code
terraform fmt

# Validate configuration
terraform validate
```

## 📦 Customization Options

### Change Instance Type
```hcl
# terraform.tfvars
instance_type = "t2.small"  # Smaller for cost savings
instance_type = "t2.large"  # Larger for performance
```

### Disable Jenkins (use localhost)
```hcl
# terraform.tfvars
enable_jenkins = false
```

### Change Region
```hcl
# terraform.tfvars
aws_region = "us-east-1"
```

## 🔄 Integration with Jenkins

Update your Jenkinsfile to use Terraform:

```groovy
stage('Deploy Infrastructure') {
    steps {
        dir('terraform') {
            sh 'terraform init'
            sh 'terraform apply -auto-approve'
        }
    }
}
```

## 🐛 Troubleshooting

### Error: Key pair not found
```bash
# Create key pair in AWS Console or:
aws ec2 create-key-pair --key-name salon-key --query 'KeyMaterial' --output text > salon-key.pem
chmod 400 salon-key.pem
```

### Error: AMI not found
```bash
# Update region or AMI ID in main.tf
```

### Can't SSH into server
```bash
# Check security group
# Verify key file permissions: chmod 400 salon-key.pem
# Check your IP in allowed_ssh_ips
```

## 📚 Next Steps

1. Set up **Route53** for custom domain
2. Add **Load Balancer** for high availability
3. Implement **Auto Scaling**
4. Use **RDS** or **DocumentDB** for managed MongoDB
5. Add **S3 + CloudFront** for static assets
6. Enable **CloudWatch** monitoring
7. Set up **VPC** for better security

## 🤝 Support

For issues or questions:
1. Check AWS CloudWatch logs
2. Review Terraform state: `terraform show`
3. Validate configuration: `terraform validate`
4. Check AWS Console for resource status
