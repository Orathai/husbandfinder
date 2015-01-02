FROM dockerfile/java:oracle-java8

# Install maven
RUN apt-get update
RUN apt-get install -y maven

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /code/pom.xml
# Adding source, compile and package into a fat jar
ADD husbandfinder-webapp /code/husbandfinder-webapp
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]
RUN ["mvn", "package"]

EXPOSE 5678
CMD ["java", "-jar", "/code/husbandfinder-webapp/target/husbandfinder-webapp-1.0-SNAPSHOT.jar"]
