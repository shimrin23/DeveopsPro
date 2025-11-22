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

        stage('Parallel Build') {
            parallel {
                stage('Build Backend') {
                    steps {
                        script {
                            echo '--- Building Backend ---'
                            docker.build("${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER}", "./backend")
                        }
                    }
                }

                stage('Build Frontend') {
                    steps {
                        script {
                            echo '--- Building Frontend ---'
                            docker.build("${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER}", "./frontend")
                        }
                    }
                }
            }
        }

        stage('Push to Registry') {
            steps {
                script {
                    docker.withRegistry('', "${REGISTRY_CRED_ID}") {
                        parallel(
                            'Push Backend': {
                                sh "docker push ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER}"
                                sh "docker tag ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:latest"
                                sh "docker push ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:latest"
                            },
                            'Push Frontend': {
                                sh "docker push ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER}"
                                sh "docker tag ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:latest"
                                sh "docker push ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:latest"
                            }
                        )
                    }
                }
            }
        }
    }

    post {
        always {
            
            script {
                sh "docker rmi ${DOCKER_REGISTRY}/${BACKEND_IMAGE}:${BUILD_NUMBER} || true"
                sh "docker rmi ${DOCKER_REGISTRY}/${FRONTEND_IMAGE}:${BUILD_NUMBER} || true"
            }
        }
    }
}