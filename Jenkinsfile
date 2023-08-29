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
         stage('Push to Artifactory') {
    steps {
        script {
            def server = Artifactory.server 'artifactory'
            def rtMaven = Artifactory.newMavenBuild()
            rtMaven.tool = "Maven"

            // Configure deployment repositories
            rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
            // Optional: You can configure a resolver repository if needed
            rtMaven.resolver server: server, repo: 'libs-release'

            // Run Maven build with deploy goal
            rtMaven.run pom: 'pom.xml', goals: 'clean deploy'
        }
    }
}

        
        
    }
}
