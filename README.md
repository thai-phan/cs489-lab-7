# ADS Spring Boot MVC + PostgreSQL

This project now includes a minimal Spring Boot MVC app backed by PostgreSQL.

## Files
- `src/main/java/org/example/AdsApplication.java`
- `src/main/java/org/example/web/HealthController.java`
- `src/main/resources/application.properties`
- `src/main/resources/config/application.properties` for the earlier JDBC smoke test
- `src/main/resources/sqlite/ads_schema.sql` for the SQLite ADS schema
- `src/main/resources/sqlite/ads_seed.sql` for repeatable sample data
- `src/main/resources/sqlite/ads.db` for the generated SQLite database

## Run

```bash
./gradlew bootRun
```

Then open:
- `http://localhost:8080/` for the MVC-style status response
- `http://localhost:8080/db/ping` to verify the PostgreSQL connection

If you want to run the earlier JDBC smoke test main from your IDE, execute `org.example.ConnectionSmokeTest`.

