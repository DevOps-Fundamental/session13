FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app
COPY backend/gradlew ./
COPY backend/gradle ./gradle
COPY backend/build.gradle backend/settings.gradle ./
RUN chmod +x ./gradlew
COPY backend/src ./src
RUN ./gradlew bootJar --no-daemon -x test && find build/libs -name "*.jar" ! -name "*-plain.jar" -exec cp {} app.jar \;

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/app.jar app.jar
ENV SERVER_PORT=8080
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
