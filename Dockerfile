# Stage 1: Build the application using Maven
FROM maven:3.8.8-eclipse-temurin-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project
COPY . .

# Build the project (skip tests if needed)
RUN mvn clean package -DskipTests

# Stage 2: Run the application using a lightweight JDK base image
FROM eclipse-temurin:8-jdk

# Set the working directory for runtime
WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
