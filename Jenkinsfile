pipeline {
    agent any

    tools {
        maven "maven.3.2.5"
    }

    stages {
         stage("Maven Build"){
        steps{
            sh" mvn -f pom.xml clean install"
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
    }
}
