# Stage 1: Build the application using Maven and Java 17
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copy the project files into the container
COPY pom.xml .
COPY src ./src

# Compile and package the application inside the container
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM eclipse-temurin:17-jdk-alpine
RUN apk add curl
VOLUME /tmp
EXPOSE 8080

# Copy the built JAR using the standard production naming convention
COPY --from=build /app/target/springboot-aws-deploy.jar springboot-aws-deploy.jar

ENTRYPOINT ["java","-jar","/springboot-aws-deploy.jar"]
