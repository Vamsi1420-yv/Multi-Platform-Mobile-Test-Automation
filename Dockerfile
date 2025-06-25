# Stage 1: Build
FROM maven:3.8.8-eclipse-temurin-8 as build

# Set working directory
WORKDIR /app

# Copy Maven settings
COPY settings.xml /root/.m2/settings.xml

# Copy pom and source
COPY pom.xml .
COPY src ./src

# Build without running tests
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
