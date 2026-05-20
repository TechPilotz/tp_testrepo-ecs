# Pull runtime image safely from Amazon ECR Public to avoid Docker Hub 429 blocks
FROM public.ecr.aws/docker/library/eclipse-temurin:17-jdk-alpine

RUN apk add curl
VOLUME /tmp
EXPOSE 8080

# Copies the JAR built by your buildspec 'mvn clean install' step
COPY target/springboot-aws-deploy.jar springboot-aws-deploy.jar

ENTRYPOINT ["java","-jar","/springboot-aws-deploy.jar"]
