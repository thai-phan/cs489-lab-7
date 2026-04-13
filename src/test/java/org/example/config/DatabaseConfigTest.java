package org.example.config;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class DatabaseConfigTest {

    @Test
    void loadsDatabaseConnectionConfiguration() {
        DatabaseConfig config = DatabaseConfig.load();

    }
}

