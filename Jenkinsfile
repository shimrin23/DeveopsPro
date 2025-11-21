pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'shimrin223' 
        
        FRONTEND_IMAGE = 'salon-frontend'
        BACKEND_IMAGE = 'salon-backend'
        
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
                    docker.build("${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER}", "./backend")
                    
                    echo '--- Building Frontend ---'
                    docker.build("${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER}", "./frontend")
                }
            }
        }

        stage('Push to Registry') {
            steps {
                script {
                    docker.withRegistry('', "${REGISTRY_CRED_ID}") {
                        echo '--- Pushing Backend ---'
                        sh "docker push ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER}"
                        sh "docker tag ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:latest"
                        sh "docker push ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:latest"

                        echo '--- Pushing Frontend ---'
                        sh "docker push ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER}"
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