pipeline {
    agent any

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
         stage('Build and Push Docker Image') {
            steps {
                // Build and push Docker image
                script {
                    def dockerImage = docker.build("aayushmalviya/calculator-app:${env.BUILD_ID}")
                    dockerImage.push()
                }
            }
        }
    


        
        
    }
}
