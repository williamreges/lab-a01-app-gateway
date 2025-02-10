FROM amazoncorretto:17-alpine
LABEL authors="william-reges"
WORKDIR /app

COPY /target/*.jar app.jar

EXPOSE 8765

ENTRYPOINT ["java", "-jar", "app.jar"]