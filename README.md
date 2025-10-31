RunClubApp
==========

**RunClubApp** is a mobile application designed to organize, track, and motivate running groups and individual runners. It aims to foster a **community spirit** while providing essential, data-driven tools for training and progress monitoring.

This project demonstrates proficiency in building a **location-aware**, data-intensive application for a dedicated fitness niche, highlighting competence in **SwiftUI**, **Core Location**, and **Supabase** for data persistence.

<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-30 at 21 50 21" src="https://github.com/user-attachments/assets/c7ef11cf-7581-40de-a6ec-4119257eee92" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-30 at 21 50 12" src="https://github.com/user-attachments/assets/4aae139e-f81d-4dd4-a377-33fcac853746" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-30 at 21 50 05" src="https://github.com/user-attachments/assets/4b9877f8-2898-418f-848c-e351ef6cb14f" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2025-10-30 at 21 50 28" src="https://github.com/user-attachments/assets/6ad193c4-934d-4665-97f5-8abad11e93fd" />

✨ Features
----------

The application is structured around three core pillars: tracking, community, and progress.

### 🏃 Activity Tracking

*   **GPS Tracking:** Records route visualization, distance, pace, elevation, and duration for every run with high precision.
    
*   **Real-Time Metrics:** Displays live speed, distance, and time during the activity for immediate feedback.
    
*   **Historical Data:** Provides a detailed, accessible log of all past runs with comprehensive summary statistics.
    
*   **HealthKit Integration (iOS):** Synchronizes run data seamlessly with the user's Apple Health records for holistic fitness tracking.    

### 📊 Progress & Goals

*   **Personal Bests (PBs):** Automatically tracks, highlights, and celebrates new personal records (e.g., fastest 5K, 10K, longest distance).
    
*   **Goal Setting:** Set and monitor personalized distance goals for the week or month, providing visual feedback on progress.
    

🛠️ Technologies Used
---------------------

This project leverages modern iOS development standards and a robust open-source backend:

*   **Language:** **Swift**
    
*   **UI Framework:** **SwiftUI** (utilizing the latest declarative patterns)
    
*   **Mapping:** **MapKit** (for displaying and tracking routes with custom overlays)
    
*   **Health Data:** **HealthKit** (for deep integration with the iOS health ecosystem)
    
*   **Location Services:** **Core Location** (for accurate, battery-efficient GPS data)
    
*   **Backend/Data Storage:** **Supabase** (used for user **Authentication**, real-time data with **Postgres**, and storage).
    

🚀 Setup and Installation
-------------------------

To get a copy of the project up and running on your local machine for development and testing, you will need **Xcode 14+** installed.

1.  **Clone the repository:**
    
2.  **Navigate to the project directory:**
    
3.  **Install Dependencies (Supabase Swift Library):**
    
    *   Open the project in Xcode:
        
    *   Navigate to **File > Add Packages...** and add the Supabase Swift library package URL.
        
4.  **Set up Supabase Configuration:**
    
    *   Create a new project in the .
        
    *   Get your **Project URL** and **Anon Key** from the project settings.
        
    *   Update the appropriate configuration file in the project (e.g., a Constants.swift file) with your Supabase credentials:
        
5.  **Enable Required Capabilities:**
    
    *   In Xcode, select the **RunClubApp** target and navigate to **Signing & Capabilities**.
        
    *   Ensure the following capabilities are enabled and properly configured for your team:
        
        *   Location Services (required for GPS tracking).
            
        *   HealthKit (required for saving and reading workout data).
            
6.  **Run the app:** Select an iOS simulator or a physical device and press **Cmd + R** to build and run the application.
    

🤝 Contributing
---------------

Contributions are welcome! If you have suggestions for features, bug reports, or want to contribute code, please feel free to open an issue or submit a pull request.

📜 License
----------

This project is licensed under the **MIT License** - see the file for details.

_This project was created by_ _**ctechasiri1**__._
