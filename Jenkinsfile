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
    }
	
    stages{
        
        stage("BUILD"){
            steps {
                sh 'mvn -s settings.xml -DskipTests install'
            }
        }
        stage("TEST"){
            sh 'mvn -s settingx.xml test'
        }
        stage("CHECK"){
            sh 'mvn -s settingx.xml checkstyle:checkstyle'
        }
    }
}
