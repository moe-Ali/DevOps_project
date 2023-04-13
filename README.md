# DevOps_project

## infrastructure on AWS
![aws_infra](https://github.com/moe-Ali/DevOps_project/blob/main/screenshots/aws_public.png)

## Jenkins Plugins:
Note: this plugins is installed using Plugin Installation Manager by Ansible inside the python code
- Maven Integration plugin
- Oracle Java SE Development Kit Installer Plugin
- Nexus Artifact Uploader
- SonarQube Scanner for Jenkins
- Slack Notification Plugin
- Build Timestamp Plugin

## Steps
clone this repo
```
git clone https://github.com/moe-Ali/DevOps_project
```
change the working directory to the cloned repo then run the python script to build the infrastructure
```
cd DevOps_project
python main.py
```
Note: Python script will output jenkins password and nexus password after the infrastructure is built and configured
on Jenkins:
- sign in using the password that the python script outputed
- Create Credentials:
    - nexuslogin => type: username with password
    - githublogin => type: ssh username with privatekey
    - sonartoken => type: secret text
    - slacktoken => type: secret text
- Configure Global tools:
    - JDK => Name: JDK_8 , JAVA_HOME: /usr/lib/jvm/java-1.8.0-openjdk-amd64
    - SonarQube Scanner => Name: sonarscanner , check mark "Install automatically"
    - Maven => Name: maven_3.9.1 , check mark "Install automatically"
- Configure System:
    - SonarQube servers => check mark "Environment variables" , Name: sonarserver , Server URL: http://{your sonarqube server ip}:9000 , Server authentication token: sonartoken
- Create Pipeline and check mark "GitHub hook trigger for GITScm polling", choose the pipeline to be from SCM, then fork my repo branch ci and use it as Repository URL
on Nexus:
- sign in using username admin and password that the python script outputed
- go to conigration then select repository:
    - Create repository Maven2 (hosted) and name it devops_project-release
    - Create repository Maven2 (hosted) and name it devops_project-snapshot
    - Create repository Maven2 (proxy) and name it devops_project-central
    - Create repository Maven2 (group) and name it devops_project-group and add devops_project-release, devops_project-snapshot, devops_project-central
run the pipeline manauly, it will abort due to a SonarQube webhook not being configured
on SonarQube:
- From projects select devops_project
- From project settings select configure webhook then create a webhook with anyname and the url: http://{your jenkins private ip}:8080/sonarqube-webhook

on github create a webhook from the forked repo to your jenkins ip

