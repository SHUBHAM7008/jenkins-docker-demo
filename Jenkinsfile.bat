pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t jenkins-static-web .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat 'docker stop jenkins-static-web || exit 0'
                bat 'docker rm jenkins-static-web || exit 0'
                bat 'docker run -d -p 8081:80 --name jenkins-static-web jenkins-static-web'
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Visit http://localhost:8081"
        }
        failure {
            echo "❌ Build or deployment failed."
        }
    }
}
