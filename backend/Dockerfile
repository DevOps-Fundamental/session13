FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app
COPY gradlew ./
COPY gradle ./gradle
COPY build.gradle settings.gradle ./
RUN chmod +x ./gradlew
COPY src ./src
RUN ./gradlew bootJar --no-daemon -x test && find build/libs -name "*.jar" ! -name "*-plain.jar" -exec cp {} app.jar \;

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/app.jar app.jar
ENV SERVER_PORT=8080
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
