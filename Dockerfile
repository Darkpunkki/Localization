# Use an official Maven image to build the project
FROM maven:3.8.4-openjdk-17-slim AS build

# Set working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml /app/
COPY src /app/src/

# Build the Maven project and create the JAR file
RUN mvn clean package -DskipTests

# Use a smaller OpenJDK image to run the JAR
FROM openjdk:17-jdk-slim

# Set the working directory inside the runtime container
WORKDIR /app

# Copy the built JAR from the build stage to the runtime stage
COPY --from=build /app/target/test.jar /app/test.jar

# Specify the command to run the JAR file
CMD ["java", "-jar", "test.jar"]
