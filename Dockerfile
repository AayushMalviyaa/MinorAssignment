FROM tomcat:9.0-jdk11-openjdk
COPY ./target/calculator-1.0-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.war
ENTRYPOINT ["catalina.sh", "run"]
