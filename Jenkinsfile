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
                sh 'npm install'
            }
        }
             
        stage('Unit Tests') {
            steps {
                sh 'npm test' // Assumes you have tests configured
            }
            post {
                always {
                    junit '**/test-results.xml' // Assumes your test results are in this format
                }
            }
        }
        
        stage('Build Angular') {
            steps {
                sh 'npm run build -- --prod' // Production build
            }
            post {
                success {
                    archiveArtifacts artifacts: 'dist/**/*', fingerprint: true
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                     {
                        dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", "--build-arg NGINX_PORT=80 .")
                    }
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