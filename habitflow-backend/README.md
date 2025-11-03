## HabitFlow Backend

Spring Boot service that powers the HabitFlow prototype. The service exposes read APIs for the iOS preview and persists seed data in MySQL via MyBatis-Plus. Redis is used for lightweight caching.

### Prerequisites

- JDK 17
- Maven 3.9+
- MySQL 8.x (database name suggestion: `habitflow`)
- Redis 6.x+

### Quick Start

1. **Create database and user**
   ```sql
   CREATE DATABASE habitflow CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   CREATE USER 'habitflow'@'%' IDENTIFIED BY 'habitflow';
   GRANT ALL PRIVILEGES ON habitflow.* TO 'habitflow'@'%';
   FLUSH PRIVILEGES;
   ```
2. **Update credentials** if you use a different username/password/host. Edit `habitflow-backend/src/main/resources/application.yml` (`spring.datasource.*` and `spring.data.redis.*` sections).
3. **Start Redis** locally (default port `6379`).
4. **Build & run**
   ```bash
   mvn -f habitflow-backend/pom.xml -DskipTests spring-boot:run
   ```
   On first launch Spring will execute `schema.sql` and `data.sql`, seeding tables with the UX-aligned sample data.

### Available APIs

| Endpoint | Description |
| --- | --- |
| `GET /api/v1/dashboard/today` | Today tab snapshot (micro plan, insight, quick actions, chat thread). |
| `GET /api/v1/dashboard/coach` | Coach tab thread, recommendation, composer metadata. |
| `GET /api/v1/dashboard/log` | Log metrics, timeline, manual capture guide. |
| `GET /api/v1/dashboard/weekly` | Weekly summary, insights, next-week micro plans. |
| `GET /api/v1/profile` | Profile identity, privacy settings, data strategy and authorizations. |

All endpoints accept an optional `userId` query parameter (default `1`) to support future multi-user seeds.

Responses are cached in Redis for 10 minutes. Flush Redis if you reload the seed data:
```bash
redis-cli FLUSHALL
```

### iOS Integration Notes

- The SwiftUI preview fetches from `http://localhost:8080` by default. Override by setting the env var `HABITFLOW_API_BASE_URL` in your Xcode scheme (e.g. `https://dev.habitflow.internal:8443`).
- If the network request fails, the view models automatically fall back to the original `HabitMockData` fixtures so previews still render.

### Validation

- Compile: `mvn -f habitflow-backend/pom.xml -DskipTests package`
- MySQL schema definition: `habitflow-backend/src/main/resources/schema.sql`
- Seed content aligned with `habitflow_ui.html` and Swift mocks: `habitflow-backend/src/main/resources/data.sql`
