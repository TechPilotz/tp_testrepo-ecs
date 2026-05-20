# Stage 1: Build the application using Maven and Java 17 (Pulled from ECR Public)
FROM public.ecr.aws/docker/library/maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copy the project files into the container
COPY pom.xml .
COPY src ./src

# Compile and package the application inside the container
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image (Pulled from ECR Public)
FROM public.ecr.aws/docker/library/eclipse-temurin:17-jdk-alpine
RUN apk add curl
VOLUME /tmp
EXPOSE 8080

# Copy the built JAR matching your production configurations
COPY --from=build /app/target/springboot-aws-deploy.jar springboot-aws-deploy.jar

ENTRYPOINT ["java","-jar","/springboot-aws-deploy.jar"]
