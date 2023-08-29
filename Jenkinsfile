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
            def server = Artifactory.server 'arti' // The instance ID defined in your Jenkins configuration
            
            def rtMaven = Artifactory.newMavenBuild()
            rtMaven.tool = "maven.3.2.5" // The name of the Maven installation in your Jenkins configuration
            
            // Deploy the artifacts to the release repository
            rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
            
            // Set up resolver for resolving dependencies
            rtMaven.resolver server: server, repo: 'libs-release' // Use the appropriate resolver repository
            
            // Run the Maven build with goals and options
            rtMaven.run pom: 'pom.xml', goals: 'clean install'
        }
    }
}


        
        
    }
}
