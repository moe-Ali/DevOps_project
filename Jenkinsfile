pipeline {
    
	agent any

	tools {
        maven "maven_3.9.1"
        jdk "JDK_8"
    }

    environment {
        NEXUS_USER = 'admin'
        NEXUS_PASS ='123'
        RELEASE_REPO = 'devops_project-release'
        CENTRAL_REPO ='devops_project-central'
        SNAP_REPO ='devops_project-snapshot'
        NEXUSIP = '192.168.52.132'
        NEXUSPORT= '8081'
        NEXUS_GRP_REPO = 'devops_project-group'
        NEXUS_LOGIN = 'nexuslogin' // nexus login credential name on jenkins
        SONARSERVER = 'sonarserver' 
        SONARSCANNER = 'sonarscaner'

    }
	
    stages{
        
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
}
