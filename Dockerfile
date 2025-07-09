FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy settings.xml with credentials
COPY settings.xml /root/.m2/settings.xml

COPY . .

# Skip tests and use custom settings.xml
RUN mvn clean package -DskipTests --settings /root/.m2/settings.xml
