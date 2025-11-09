pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/shimrin23/DeveopsProj.git', 
                    credentialsId: 'github-creds'
            }
        }
        stage('Terraform Init') {
            steps {
                dir('Terraform-EC2') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir('Terraform-EC2') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
