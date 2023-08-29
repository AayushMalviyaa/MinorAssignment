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
                    def server = Artifactory.server 'ArtifactoryServer'
                    def rtMaven = Artifactory.newMavenBuild()
                    rtMaven.tool = "Maven"
                    rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
                    rtMaven.resolver server: server, repo: 'libs-release'
                    rtMaven.run pom: 'pom.xml', goals: 'clean install'
                }
            }
        }
        
        
    }
}
