# 🏃‍♂️ RunClubApp (Yak Club)

**RunClubApp** is a high-performance, full-stack mobile application designed to organize, track, and motivate running communities. The project leverages **Supabase** to provide a robust, scalable backend, allowing for real-time data synchronization, secure authentication, and efficient management of location-intensive data.

This project showcases proficiency in building **location-aware**, data-intensive applications, highlighting expertise in **SwiftUI**, **Combine/Swift Concurrency**, and **PostgreSQL** integration.

<p align="center">
  <img width="200" alt="Activity Tracking" src="https://github.com/user-attachments/assets/c7ef11cf-7581-40de-a6ec-4119257eee92" />
  <img width="200" alt="Progress Metrics" src="https://github.com/user-attachments/assets/4aae139e-f81d-4dd4-a377-33fcac853746" />
  <img width="200" alt="Community Feed" src="https://github.com/user-attachments/assets/4b9877f8-2898-418f-848c-e351ef6cb14f" />
  <img width="200" alt="User Profile" src="https://github.com/user-attachments/assets/d695d2f5-9d21-4e5a-9fb5-f5a6cfd036de" />
</p>

---

## 🏗 Project Architecture

RunClubApp utilizes a modern mobile-to-cloud architecture. By leveraging **Supabase**, the app benefits from a direct, secure connection to a PostgreSQL database, handled via **Row Level Security (RLS)** to ensure data integrity and user privacy.

* **`RunClubApp/`**: Native iOS application built with **SwiftUI**.
* **Supabase Layer**: Manages Authentication, Real-time Database (PostgreSQL), and Cloud Storage for user-generated content.

---

## ✨ Features

### 🏃 Activity Tracking
* **Precision GPS Tracking:** Real-time route visualization using **MapKit** and **Core Location**.
* **Live Metrics:** Instant feedback on pace, elevation gain, and duration.
* **HealthKit Integration:** Synchronizes workouts to Apple Health to contribute to activity rings.

### 📊 Progress & Social
* **Personal Bests (PBs):** Automated recognition of milestones (Fastest 5K, Longest Run).
* **Community Spirit:** Join clubs, participate in group goals, and view real-time leaderboards powered by **Supabase Realtime**.
* **Historical Analysis:** Comprehensive breakdown of performance trends stored and queried from PostgreSQL.

---

## 🛠 Tech Stack

| Component | Technology |
| :--- | :--- |
| **Frontend** | **SwiftUI**, Swift 6.x, MapKit, HealthKit, Core Location |
| **Backend** | **Supabase** (PostgREST, GoTrue Auth) |
| **Database** | **PostgreSQL** |
| **Authentication** | Supabase Auth (Email/Social) |
| **Architecture** | **MVVM** + Repository Pattern |

---

## 🚀 Setup and Installation

### Prerequisites
* **Xcode 16+**
* **Swift 6.0+**
* **Supabase Account** (Free tier works perfectly)

### 1. Supabase Backend Setup
1.  Create a new project at [database.new](https://database.new).
2.  In the **SQL Editor**, run your table migrations (Users, Activities, Clubs).
3.  Enable **Row Level Security (RLS)** on all tables to secure user data.
4.  Navigate to **Project Settings > API** to retrieve your `SUPABASE_URL` and `SUPABASE_ANON_KEY`.

### 2. Frontend Setup (iOS)
1.  Open `RunClubApp.xcodeproj` in Xcode.
2.  Add your Supabase credentials to your configuration (e.g., `Secrets.plist` or a dedicated `SupabaseManager` config):
    * `SUPABASE_URL`
    * `SUPABASE_ANON_KEY`
3.  Ensure **Location Services** and **HealthKit** capabilities are enabled in the Project Settings.
4.  Build and run (**Cmd + R**).

---

## 🔒 Security & Data Integrity
* **Row Level Security (RLS):** Policies are configured so users can only read/write their own running data and public club info.
* **PostGIS:** (Planned) Utilizing PostgreSQL's PostGIS extension for advanced geospatial queries and route matching.
* **Secure Storage:** Authentication tokens are stored securely in the iOS Keychain via the Supabase Swift SDK.

---

## 🤝 Contributing
Contributions are welcome! Please open an issue or submit a pull request for any feature suggestions or bug reports.

## 📜 License
This project is licensed under the **MIT License**.

---
_Developed with ❤️ by [**ctechasiri1**](https://github.com/ctechasiri1)_
