pipeline {
    agent any

 

    tools {
        maven "maven.3.2.5"
    }

 

    stages {
        stage('Build') {
            steps {

                git  'https://github.com/mchatrola/calculator.git'
                sh "mvn  clean package"
            }
        }
        stage('Test'){
             steps {

                sh "mvn test"

            }

 

            post {

                success {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
    }
}