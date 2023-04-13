FROM tomcat
RUN apt update && apt install -y openjdk-8-jdk maven
WORKDIR /app
COPY . /app

COPY target /tmp
RUN rm -rf /usr/local/tomcat/webapps/* 
RUN mv /tmp/target/vprofile-vs.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh","run"]