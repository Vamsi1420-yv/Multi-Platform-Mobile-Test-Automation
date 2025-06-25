# Stage 1: Build using Maven with JDK 8
FROM maven:3.8.8-eclipse-temurin-8 AS build

# Set the working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project without running tests
RUN mvn clean package -DskipTests

# Stage 2: Run using lightweight JDK 8 runtime
FROM openjdk:8-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Command to run the app
CMD ["java", "-jar", "app.jar"]
