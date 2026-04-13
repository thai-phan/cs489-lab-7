import org.gradle.api.plugins.JavaPluginExtension
import org.gradle.api.tasks.testing.Test
import org.gradle.jvm.toolchain.JavaLanguageVersion

plugins {
    id("java")
    id("org.springframework.boot") version "3.3.5"
    id("io.spring.dependency-management") version "1.1.6"
}

group = "org.example"
version = "1.0-SNAPSHOT"

extensions.configure<JavaPluginExtension> {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(17))
    }
}

repositories {
    mavenCentral()
}

dependencies {
    add("implementation", "org.springframework.boot:spring-boot-starter-web")
    add("implementation", "org.springframework.boot:spring-boot-starter-jdbc")
    add("implementation", "org.springframework.boot:spring-boot-starter-data-jpa")
    add("implementation", "jakarta.persistence:jakarta.persistence-api:3.1.0")
    add("runtimeOnly", "org.postgresql:postgresql:42.7.7")
    add("testImplementation", "org.springframework.boot:spring-boot-starter-test")
    add("testRuntimeOnly", "org.junit.platform:junit-platform-launcher")
}

tasks.named<Test>("test") {
    useJUnitPlatform()
}