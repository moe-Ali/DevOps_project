# DevOps_project

# Jenkins Plugins:
Maven Integration
jdk
Nexus Artifact Uploader
Sonarqube Scanner
Slack Notification

# JAVA_HOME
/usr/lib/jvm/java-1.8.0-openjdk-amd64

# envrioment variables:
NEXUS_USER = 'admin'
NEXUS_PASS = ''
RELEASE_REPO = 'devops_project-release'
CENTRAL_REPO ='devops_project-central'
SNAP_REPO ='devops_project-snapshot'
NEXUSIP = ''
NEXUSPORT= '8081'
NEXUS-GRP-REPO = 'devops_project-group'
NEXUS_LOGIN = 'nexuslogin'

# jenkins credentials
nexuslogin => type: username with password
githublogin => type: ssh username with privatekey
sonartoken => type: secret text
slacktoken => type: secret tex