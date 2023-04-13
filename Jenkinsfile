pipeline {
    
	agent any

	tools {
        maven "maven_3.9.1"
        jdk "JDK_8"
    }

    environment {
        NEXUS_USER = ''
        NEXUS_PASS = ''
        RELEASE_REPO = 'devops_project-release'
        CENTRAL_REPO ='devops_project-central'
        SNAP_REPO ='devops_project-snapshot'
        NEXUS_GRP_REPO = 'devops_project-group'
        NEXUSIP = '192.168.52.132'
        NEXUSPORT= '8081'
        NEXUS_LOGIN = 'nexuslogin' 
        SONARSERVER = 'sonarserver' 
        SONARSCANNER = 'sonarscanner'

    }
	
    stages{
        stage('Set environment variable') {
            steps {
                // to set out nexus username and password as environment variables without showing them in the code #security
                withCredentials([usernamePassword(credentialsId: 'nexuslogin', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    script {
                        env.NEXUS_USER = sh(script: 'echo $USERNAME', returnStdout: true).trim()
                        env.NEXUS_PASS = sh(script: 'echo $PASSWORD', returnStdout: true).trim()
                    }
                }
            }
        }
        stage("BUILD"){
            steps {
                sh 'mvn -s settings.xml -DskipTests install'
            }
        }
        stage("TEST"){
            steps {
            sh 'mvn -s settings.xml test'
            }
        }
        stage("CHECK"){
            steps {
            sh 'mvn -s settings.xml checkstyle:checkstyle'
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
                    -Dsonar.sources=src/ \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                    -Dsonar.junit.reportsPath=target/surefire-reports/ \
                    -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                    -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }
        // stage('QUALITY GATE') {
        //     steps {
        //         timeout(time: 5, unit: 'MINUTES') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }
        stage('ARTIFACT UPLOAD') {
            steps{
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: "${NEXUSIP}:${NEXUSPORT}",
                    groupId: 'QA',
                    version: "${BUILD_ID}-${BUILD_TIMESTAMP}",
                    repository: "${RELEASE_REPO}",
                    credentialsId: "${NEXUS_LOGIN}",
                    artifacts: [
                        [artifactId: 'vproapp' ,
                        classifier: '',
                        file: 'target/vprofile-v2.war',
                        type: 'war']
                    ]
                )
            }
        }

        stage('CONTAINER BUILD') {
            steps {
                echo "This is build stage number ${BUILD_NUMBER}"
                withCredentials([usernamePassword(credentialsId: 'dockerhublogin', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh """
                    docker login --username ${USERNAME} --password ${PASSWORD}
                    docker build -t ${USERNAME}/devops_project:${BUILD_NUMBER} .
                """
                }
            }
        }
        stage('CONTAINER PUSH') {
            steps {
                echo "This is push stage number ${BUILD_NUMBER}"
                withCredentials([usernamePassword(credentialsId: 'dockerhublogin', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh """
                    docker push ${USERNAME}/devops_project:${BUILD_NUMBER}
                    echo ${BUILD_NUMBER} > ../push_number.txt
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