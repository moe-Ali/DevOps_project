pipeline {
    
	agent any

	tools {
        maven "maven_3.9.1"
        jdk "JDK_8"
    }

    environment {
        RELEASE_REPO = 'devops_project-release'
        CENTRAL_REPO ='devops_project-central'
        SNAP_REPO ='devops_project-snapshot'
        NEXUS_GRP_REPO = 'devops_project-group'
        NEXUSIP = '192.168.52.132'
        NEXUSPORT= '8081'
        DOCKER_NEXUS_PORT = '5000'
        NEXUS_LOGIN = 'nexuslogin' 
        SONARSERVER = 'sonarserver' 
        SONARSCANNER = 'sonarscanner'
    }
	
    stages{
        stage("BUILD"){
            steps {
                sh 'mvn -DskipTests install'
            }
        }
        stage('CODE ANALYSIS with SONARQUBE') {
            environment {
                scannerHome = tool "${SONARSCANNER}"
            }
            steps {
                withSonarQubeEnv("${SONARSERVER}") {
                sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=devops_project \
                    -Dsonar.projectName=devops_porject \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.sources=src/'''
                }
            }
        }
        stage('QUALITY GATE') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('CONTAINER BUILD') {
            steps {
                echo "This is build stage number ${BUILD_NUMBER}"
                withCredentials([usernamePassword(credentialsId: "${NEXUS_LOGIN}", usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASSWORD')]) {
                sh """
                    docker login --username ${NEXUS_USER} --password ${NEXUS_PASSWORD} http://${NEXUSIP}:${DOCKER_NEXUS_PORT}
                    docker build -t ${NEXUSIP}:${DOCKER_NEXUS_PORT}/devops_project:${BUILD_NUMBER} .
                """
                }
            }
        }
        stage('CONTAINER PUSH') {
            steps {
                echo "This is push stage number ${BUILD_NUMBER}"
                withCredentials([usernamePassword(credentialsId: "${NEXUS_LOGIN}", usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASSWORD')]) {
                sh """
                    docker push ${NEXUSIP}:${DOCKER_NEXUS_PORT}/devops_project:${BUILD_NUMBER}
                    echo ${BUILD_NUMBER} > ../image_number.txt
                """
                }
            }
        }
    }
    post{
        failure{
            slackSend (channel:"jenkins", color:"#FF0000", message:"FAILED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        success{
            slackSend (channel:"jenkins", color:"#00FF00", message:"SUCCEEDED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        aborted{
            slackSend (channel:"jenkins", color:"#808080", message:"ABORTED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
    }
}