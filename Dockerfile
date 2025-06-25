# Stage 1: Build the application using Maven and JDK 8
FROM maven:3.8.8-openjdk-8-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy everything to the container
COPY . .

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Use a lightweight JDK 8 runtime
FROM openjdk:8-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
