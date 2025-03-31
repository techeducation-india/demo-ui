pipeline {
    agent any
    
    environment {
        // Configure these variables according to your project
        DOCKER_REGISTRY = 'docker.io' // Change if using a different registry
        DOCKER_IMAGE_NAME = 'sample-angluar-app' // Replace with your Docker Hub username
        CONTAINER_NAME = 'sample-ui-app'
        DOCKER_IMAGE_TAG = "latest"
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Jenkins credentials ID for Docker Hub
    }
    
    stages {
        
        stage('Install Dependencies') {
            steps {
                bat "npm install"
                bat "npm install -g @angular/cli"
            }
        }
                     
        stage('Build Angular') {
            steps {
                bat "npm run build "
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    bat "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
                }
            }
        }
      
        
        
        stage('Deploy to Docker') {
            steps {
                script {
                       bat """
                    docker stop ${CONTAINER_NAME} >nul 2>&1 || echo Container was not running
                    docker rm ${CONTAINER_NAME} >nul 2>&1 || echo Container did not exist
                    docker run -d --name ${CONTAINER_NAME} --network workshop -p 4200:4200 ${IMAGE_NAME}:${IMAGE_TAG} 
                    """
                    }
            }
        }
    }
    
    post {
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build or deployment failed!'
        }
    }
}