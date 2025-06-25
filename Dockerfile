# Use official Maven image with JDK 8
FROM maven:3.8.8-openjdk-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy your Maven project files into the container
COPY pom.xml .
COPY src ./src

# Package the application (skip tests to speed up build)
RUN mvn clean package -DskipTests

# ------------------------------------------------------------------

# Create a minimal runtime image with just JDK 8 (no Maven)
FROM openjdk:8-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose port (optional: if your app is a web service)
EXPOSE 8080

# Command to run the JAR
CMD ["java", "-jar", "app.jar"]
