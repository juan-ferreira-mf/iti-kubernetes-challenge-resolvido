FROM eclipse-temurin:8-jdk-jammy AS build

WORKDIR /app

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-5.6.4-bin.zip && \
    unzip gradle-5.6.4-bin.zip && \
    rm gradle-5.6.4-bin.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/app/gradle-5.6.4/bin:${PATH}"
ENV GRADLE_OPTS="-Dorg.gradle.daemon=false"

COPY app/build.gradle ./build.gradle.original
COPY app/src/ src/

RUN mkdir -p /app/local-maven-repo/io/ktor/ktor-server-netty/0.9.4

RUN sed 's|jcenter()|mavenCentral()|g' build.gradle.original > build.gradle.tmp && \
    sed -i '/maven { url "https:\/\/dl.bintray.com\/kotlin\/ktor" }/d' build.gradle.tmp && \
    sed -i '/repositories {/a\    maven { url "file:///app/local-maven-repo" }' build.gradle.tmp && \
    mv build.gradle.tmp build.gradle

RUN sed -i "s|ext.kotlin_version = '.*'|ext.kotlin_version = '1.3.72'|g" build.gradle && \
    sed -i "s|ext.ktor_version = '.*'|ext.ktor_version = '1.0.0'|g" build.gradle && \
    gradle build --no-daemon

FROM eclipse-temurin:8-jre-jammy

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENV TARGET=World
ENV PORT=8080

ENTRYPOINT ["java", "-jar", "app.jar"]
