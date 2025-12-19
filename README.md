# 🏃‍♂️ RunClubApp (Yak Club)

**RunClubApp** is a high-performance, full-stack mobile application designed to organize, track, and motivate running communities. By combining a native **SwiftUI** frontend with a **Vapor** (Swift-based) backend and **Supabase** for real-time data, this project delivers a seamless, type-safe experience across the entire stack.

This project showcases proficiency in building **location-aware**, data-intensive applications, highlighting expertise in **Swift Concurrency**, **Core Location**, and **RESTful API design**.

<p align="center">
  <img width="200" alt="Activity Tracking" src="https://github.com/user-attachments/assets/c7ef11cf-7581-40de-a6ec-4119257eee92" />
  <img width="200" alt="Progress Metrics" src="https://github.com/user-attachments/assets/4aae139e-f81d-4dd4-a377-33fcac853746" />
  <img width="200" alt="Community Feed" src="https://github.com/user-attachments/assets/4b9877f8-2898-418f-848c-e351ef6cb14f" />
  <img width="200" alt="User Profile" src="https://github.com/user-attachments/assets/d695d2f5-9d21-4e5a-9fb5-f5a6cfd036de" />
</p>

---

## 🏗 Project Architecture

This repository is managed as a **Monorepo**, allowing for shared data models between the frontend and backend. This structure ensures that changes to data structures are reflected immediately across both the app and the server.



* **`RunClubApp/`**: The native iOS application built with SwiftUI.
* **`RunClubBackend/`**: The server-side Swift (Vapor) API handling business logic and synchronization.

---

## ✨ Features

### 🏃 Activity Tracking
* **Precision GPS Tracking:** Real-time route visualization using **MapKit** and **Core Location**.
* **Live Metrics:** Instant feedback on pace, elevation gain, and duration.
* **HealthKit Integration:** Seamlessly syncs workouts to Apple Health to contribute to activity rings.

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
| **Database** | **Postgres** via **Supabase** |
| **Auth** | **Supabase Auth** (JWT-based) |
| **Architecture** | **MVVM** + Dependency Injection |

---

## 🚀 Setup and Installation

### Prerequisites
* **Xcode 15+**
* **Swift 6.0+**
* **Vapor Toolbox** (`brew install vapor`)

### 1. Backend Setup (Vapor)
1. Navigate to the backend directory: `cd RunClubBackend`.
2. Create a `.env` file: `cp .env.example .env`.
3. Add your **Supabase URL** and **Service Role Key** to the `.env` file.
4. Run the server: `swift run`.

### 2. Frontend Setup (iOS)
1. Open `RunClubApp.xcodeproj` in Xcode.
2. Ensure **Location Services** and **HealthKit** capabilities are enabled in the "Signing & Capabilities" tab.
3. Update your `Constants.swift` with your local Vapor URL (e.g., `http://localhost:8080`) and your Supabase credentials.
4. Build and run (**Cmd + R**) on a simulator or device.

---

## 🔒 Security
* **Secrets Management:** Sensitive keys are managed via environment variables and are excluded from version control via `.gitignore`.
* **Type Safety:** Shared `Codable` models ensure that the API and the App never fall out of sync.

---

## 🤝 Contributing
Contributions are welcome! If you have suggestions for features or bug reports, please feel free to open an issue or submit a pull request.

## 📜 License
This project is licensed under the **MIT License**.

---
_Developed with ❤️ by [**ctechasiri1**](https://github.com/ctechasiri1)_
