package org.example;

import org.example.config.DatabaseConfig;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class ConnectionSmokeTest {

    private ConnectionSmokeTest() {
    }

    public static void main(String[] args) {
        DatabaseConfig config = DatabaseConfig.load();

        if (args.length > 0) {
            System.out.println("Ignoring command-line arguments for the connection smoke test.");
        }

        try {
            Class.forName(config.driverClassName());
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load JDBC driver: " + config.driverClassName());
            e.printStackTrace(System.err);
            System.exit(1);
        }

        try (Connection connection = DriverManager.getConnection(
                config.jdbcUrl(),
                config.username(),
                config.password())) {
            System.out.println("Connection successful.");
            System.out.println("JDBC URL: " + config.jdbcUrl());
            System.out.println("User: " + connection.getMetaData().getUserName());
            System.out.println("Database: " + connection.getMetaData().getDatabaseProductName());
            System.out.println("Version: " + connection.getMetaData().getDatabaseProductVersion());
        } catch (SQLException e) {
            System.err.println("Connection failed: " + e.getMessage());
            e.printStackTrace(System.err);
            System.exit(1);
        }
    }
}

