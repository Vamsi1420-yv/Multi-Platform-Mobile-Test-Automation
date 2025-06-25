# Use a valid Maven image with JDK 8
FROM maven:3.8.8-jdk-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the Maven project (skipping tests for speed)
RUN mvn clean package -DskipTests

# Use a slim JDK base image for runtime
FROM openjdk:8-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Run the jar file
CMD ["java", "-jar", "app.jar"]
