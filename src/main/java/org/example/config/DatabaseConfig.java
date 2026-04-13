package org.example.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;
import java.util.Properties;

public final class DatabaseConfig {
    private final String url;
    private final String jdbcUrl;
    private final String username;
    private final String password;
    private final String driverClassName;

    private DatabaseConfig(String url, String jdbcUrl, String username, String password, String driverClassName) {
        this.url = url;
        this.jdbcUrl = jdbcUrl;
        this.username = username;
        this.password = password;
        this.driverClassName = driverClassName;
    }

    public static DatabaseConfig load() {
        Properties properties = new Properties();

        try (InputStream inputStream = DatabaseConfig.class.getClassLoader().getResourceAsStream("config/application.properties")) {
            if (inputStream == null) {
                throw new IllegalStateException("Missing config/application.properties on the classpath");
            }
            properties.load(inputStream);
        } catch (IOException e) {
            throw new IllegalStateException("Unable to read config/application.properties", e);
        }

        return new DatabaseConfig(
                required(properties, "database.url"),
                required(properties, "database.jdbc-url"),
                required(properties, "database.username"),
                required(properties, "database.password"),
                required(properties, "database.driver")
        );
    }

    private static String required(Properties properties, String key) {
        return Objects.requireNonNull(properties.getProperty(key), "Missing required property: " + key);
    }

    public String url() {
        return url;
    }

    public String jdbcUrl() {
        return jdbcUrl;
    }

    public String username() {
        return username;
    }

    public String password() {
        return password;
    }

    public String driverClassName() {
        return driverClassName;
    }
}

