pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
    }

    stages {
        stage('Checkout Terraform') {
            steps {
                git url: 'https://github.com/shimrin23/DeveopsPro.git', branch: 'main', credentialsId: 'github-creds'
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
