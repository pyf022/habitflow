## HabitFlow Admin (Web)

React + Vite web console that connects to the HabitFlow Spring Boot backend for quick QA of the different dashboard payloads.

### Prerequisites

- Node.js 18+
- npm 9+ (or a compatible pnpm/yarn, adjust commands accordingly)

### Getting Started

```bash
cd habitflow-admin
npm install
npm run dev
```

The Vite dev server runs on [http://localhost:5173](http://localhost:5173) and proxies `/api/*` calls to the Spring backend at `http://localhost:8080`. Make sure the backend is already running (`mvn -f habitflow-backend/pom.xml spring-boot:run`) before opening the app.

### Configuration

- To target a non-local backend, create a `.env` file with `VITE_API_BASE_URL=https://your-host`.
- The user ID selector in the header forwards the value via the `userId` query parameter used by all backend endpoints.

### Build

```bash
npm run build
npm run preview
```

The production bundle is emitted to `habitflow-admin/dist`. It can be served behind any static file server that forwards API requests to the Java service.
