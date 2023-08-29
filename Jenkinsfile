pipeline {
    agent any
 environment {
        DOCKER_HUB_CREDENTIALS = credentials('97c36c51-b00f-4bd1-911b-3143b0f3b00d')
    }
    tools {
        maven "maven.3.2.5"
    }

    stages {
        stage("Maven Build") {
            steps {
                sh "mvn -f pom.xml clean install"
            }
        }
        
        stage('Test') {
            steps {
                sh "mvn test"
            }
            post {
                success {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Sonar Analysis') {
            steps {
                withSonarQubeEnv('sonarqube-9.4') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
         stage("Pushing Artifacts"){
            steps{
                rtUpload (
                serverId: 'arti',
                spec: '''{
                "files": [
                    {
                    "pattern": "*.jar",
                    "target": "Main/"
                    }
                ]
                }''',
                )
            }
        }
         stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("aayushmalviya/calculator-app:${env.BUILD_ID}", "-f Dockerfile .")
                }
            }
        }
        stage('Push Docker Image') {
    steps {
        script {
            // Push the Docker image to Docker Hub
            docker.withRegistry('https://registry.hub.docker.com', '97c36c51-b00f-4bd1-911b-3143b0f3b00d') {
                docker.image("aayushmalviya/calculator-app:${env.BUILD_ID}").push()
            }
        }
    }
}
    


        
        
    }
}
