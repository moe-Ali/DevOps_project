FROM tomcat
RUN apt update && apt install -y openjdk-8-jdk maven
COPY . /tmp
RUN cd /tmp && mvn install
RUN rm -rf /usr/local/tomcat/webapps/* && mv /tmp/target/vprofile-vs.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh","run"]