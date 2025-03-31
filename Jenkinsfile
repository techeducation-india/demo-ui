pipeline {
    agent any
    
    environment {
        // Configure these variables according to your project
        DOCKER_REGISTRY = 'docker.io' // Change if using a different registry
        DOCKER_IMAGE_NAME = 'sample-ui-app' // Replace with your Docker Hub username
        CONTAINER_NAME = 'sample-ui-app'
        DOCKER_IMAGE_TAG = "latest"
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Jenkins credentials ID for Docker Hub
    }
    
    stages {
        
        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }
                     
        stage('Build Angular') {
            steps {
                bat 'npm run build '
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
      
        
        
        stage('Deploy to Docker') {
            steps {
                script {
                       bat """
                    docker stop ${CONTAINER_NAME} >nul 2>&1 || echo Container was not running
                    docker rm ${CONTAINER_NAME} >nul 2>&1 || echo Container did not exist
                    docker run -d --name ${CONTAINER_NAME} --network workshop -p 80:80 ${IMAGE_NAME}:${IMAGE_TAG} 
                    """
                    }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            slackSend(color: 'good', message: "Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
        }
        failure {
            slackSend(color: 'danger', message: "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
        }
    }
}