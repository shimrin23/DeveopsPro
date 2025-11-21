pipeline {
    agent any

    environment {
        // REPLACE with your actual Docker Hub username
        DOCKER_REGISTRY = 'shimrin223' 
        
        // Image Names
        FRONTEND_IMAGE = 'salon-frontend'
        BACKEND_IMAGE = 'salon-backend'
        
        // Credentials ID from Jenkins
        REGISTRY_CRED_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    echo '--- Building Backend ---'
                    // Build Backend using the Dockerfile in ./backend
                    docker.build("${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER}", "./backend")
                    
                    echo '--- Building Frontend ---'
                    // Build Frontend using the Dockerfile in ./frontend
                    docker.build("${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER}", "./frontend")
                }
            }
        }

        stage('Push to Registry') {
            steps {
                script {
                    docker.withRegistry('', "${REGISTRY_CRED_ID}") {
                        echo '--- Pushing Backend ---'
                        // Push Versioned Tag
                        sh "docker push ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER}"
                        // Tag and Push 'latest'
                        sh "docker tag ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:latest"
                        sh "docker push ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:latest"

                        echo '--- Pushing Frontend ---'
                        // Push Versioned Tag
                        sh "docker push ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER}"
                        // Tag and Push 'latest'
                        sh "docker tag ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:latest"
                        sh "docker push ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:latest"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up images to save space on the Jenkins server
            sh "docker system prune -af"
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}