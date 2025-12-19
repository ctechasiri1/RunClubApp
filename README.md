# 🏃‍♂️ RunClubApp (Yak Club)

**RunClubApp** is a high-performance, full-stack mobile application designed to organize, track, and motivate running communities. Originally built with a BaaS (Backend-as-a-Service) approach, the project has migrated to a **100% Swift stack**, utilizing a custom **Vapor** backend for maximum control, type safety, and code sharing between the client and server.

This project showcases proficiency in building **location-aware**, data-intensive applications, highlighting expertise in **Swift Concurrency**, **Fluent ORM**, and **RESTful API design**.

<p align="center">
  <img width="200" alt="Activity Tracking" src="https://github.com/user-attachments/assets/c7ef11cf-7581-40de-a6ec-4119257eee92" />
  <img width="200" alt="Progress Metrics" src="https://github.com/user-attachments/assets/4aae139e-f81d-4dd4-a377-33fcac853746" />
  <img width="200" alt="Community Feed" src="https://github.com/user-attachments/assets/4b9877f8-2898-418f-848c-e351ef6cb14f" />
  <img width="200" alt="User Profile" src="https://github.com/user-attachments/assets/d695d2f5-9d21-4e5a-9fb5-f5a6cfd036de" />
</p>

---

## 🏗 Project Architecture

This repository is managed as a **Monorepo**, facilitating a shared codebase for data models. By moving from Supabase to Vapor, the app now uses a mediated architecture where the backend controls all data validation and business logic.



* **`RunClubApp/`**: Native iOS application built with **SwiftUI**.
* **`RunClubBackend/`**: Server-side API built with **Vapor**, using **Fluent** to interface with a PostgreSQL database.

---

## ✨ Features

### 🏃 Activity Tracking
* **Precision GPS Tracking:** Real-time route visualization using **MapKit** and **Core Location**.
* **Live Metrics:** Instant feedback on pace, elevation gain, and duration.
* **HealthKit Integration:** Synchronizes workouts to Apple Health to contribute to activity rings.

### 📊 Progress & Social
* **Personal Bests (PBs):** Automated recognition of milestones (Fastest 5K, Longest Run).
* **Community Spirit:** Join clubs, participate in group goals, and view real-time leaderboards.
* **Historical Analysis:** Comprehensive breakdown of monthly and yearly performance trends.

---

## 🛠 Tech Stack

| Component | Technology |
| :--- | :--- |
| **Frontend** | **SwiftUI**, Swift 6.0, MapKit, HealthKit, Core Location |
| **Backend** | **Vapor 4** (Server-Side Swift), Swift Concurrency |
| **Database** | **PostgreSQL** (via Fluent ORM) |
| **Data Models** | **Shared Swift Package** (DTOs used by both App & Server) |
| **Architecture** | **MVVM** + Dependency Injection |

---

## 🚀 Setup and Installation

### Prerequisites
* **Xcode 15+**
* **Swift 6.0+**
* **Vapor Toolbox** (`brew install vapor`)
* **Docker** (Recommended for running a local Postgres instance)

### 1. Backend Setup (Vapor)
1. Navigate to the backend directory: `cd RunClubBackend`.
2. Create your environment file: `cp .env.example .env`.
3. Configure your `DATABASE_URL` in `.env`.
4. Run migrations and start the server: `swift run App migrate` then `swift run App serve`.

### 2. Frontend Setup (iOS)
1. Open `RunClubApp.xcodeproj` in Xcode.
2. Ensure **Location Services** and **HealthKit** capabilities are enabled.
3. Update your Networking layer to point to your local Vapor instance (e.g., `http://localhost:8080`).
4. Build and run (**Cmd + R**).

---

## 🔒 Security & Migration
* **Vapor Migration:** This project marks the transition from Supabase's managed services to a custom-built Swift API, providing better control over authentication flows and database schema migrations.
* **Secrets Management:** Sensitive keys are managed via environment variables and are excluded from version control.

---

## 🤝 Contributing
Contributions are welcome! Please open an issue or submit a pull request for any feature suggestions or bug reports.

## 📜 License
This project is licensed under the **MIT License**.

---
_Developed with ❤️ by [**ctechasiri1**](https://github.com/ctechasiri1)_
