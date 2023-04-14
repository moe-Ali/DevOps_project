FROM tomcat
RUN apt update && apt install -y openjdk-8-jdk maven
COPY . /tmp
RUN rm -rf /usr/local/tomcat/webapps/* 
RUN mv /tmp/target/devops_project.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh","run"]