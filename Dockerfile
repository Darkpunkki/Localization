FROM maven:latest

WORKDIR /app

COPY pom.xml /app/

COPY src /app/

RUN mvn package

cmd ["java", "-jar", "target/test.jar"]


