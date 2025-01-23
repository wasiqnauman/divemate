# Divemate 🌊

**Your Personal Scuba Diving Assistant**

Divemate is a full-stack mobile and web application designed to enhance the diving experience. It serves as a personal assistant to log dives, track progress, and connect with divers worldwide. Built using **Flutter** for cross-platform compatibility and powered by **Firebase** for a robust and scalable backend, Divemate provides a seamless experience for iOS, Android, and Web users.

---

## 🚀 Features

- **Dive Logging**: Track your dives, locations, and key metrics with ease.
- **Global Connectivity**: Connect with divers from around the globe to share experiences and insights.
- **Cross-Platform Support**: One app for all devices – available on iOS, Android, and the web.
- **Cloud Storage**: All data is securely stored and synced in real-time using Firebase.
- **User Profiles**: Create personalized profiles to showcase your diving achievements.

---

## 📸 Screenshots

### Login Screen

![Login Screen](docs/login.png)

### Main Menu

![Main Menu](docs/menu.png)

### Profile Page

![Profile Page](docs/profile.png)

---

## 🛠️ Tech Stack

### **Frontend**

- **Flutter**: Cross-platform UI toolkit for creating native iOS/Android and web applications.

### **Backend**

- **Firebase**:
  - **Firebase Authentication**: Secure user authentication and account management.
  - **Cloud Firestore**: Real-time database for storing user data and dive logs.
  - **Cloud Functions**: Serverless functions for backend logic and automation.
  - **Storage**: Media uploads and storage (e.g., photos of dives).

---

## 📚 Getting Started

### Prerequisites

- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install)).
- Firebase project set up ([Firebase Console](https://console.firebase.google.com/)).

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/divemate.git
   cd divemate
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase:

   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) from your Firebase project.
   - Place them in the respective directories:
     - `android/app/` for Android.
     - `ios/Runner/` for iOS.

4. Run the app:
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```plaintext
divemate/
├── lib/               # Main application code (Flutter)
│   ├── screens/       # UI screens (Login, Menu, Profile, etc.)
│   ├── services/      # Firebase and backend services
│   ├── models/        # Data models for dive logs, users, etc.
│   └── utils/         # Utility functions and helpers
├── assets/            # App assets (icons, images, etc.)
├── android/           # Android-specific configuration
├── ios/               # iOS-specific configuration
├── web/               # Web-specific configuration
├── pubspec.yaml       # Flutter dependencies
├── README.md          # Project documentation
└── ...
```

---

## 🌐 Deployment

Divemate is designed to be deployed across multiple platforms. Below are the deployment options:

### iOS & Android

- Build the app using `flutter build apk` (Android) or `flutter build ios` (iOS).
- Publish the app on the App Store and Google Play Store.

### Web

- Build the web app:
  ```bash
  flutter build web
  ```
- Deploy on a hosting service such as Firebase Hosting, Netlify, or AWS.

---

## 🧪 Testing

Run the following command to test the app locally:

```bash
flutter test
```

---

## 🤝 Contributing

We welcome contributions to Divemate! To get started:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/new-feature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add new feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/new-feature
   ```
5. Open a pull request.

---

## 🛡️ License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📧 Contact

For any questions, suggestions, or feedback, feel free to reach out:

- **Email**: wasiq.qureshi@hotmail.com
- **GitHub**: [wasiqnauman](https://github.com/wasiqnauman)

---

Thank you for exploring **Divemate**! 🐠 Dive safe and stay connected!
