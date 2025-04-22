# 🧠 Mini Task Hub

A minimal task management app built with Flutter. It supports real-time task syncing using Firebase Firestore and user authentication via Firebase Auth. Tasks can be added, edited, marked as complete, or deleted. Toggle between light and dark themes seamlessly.

---

## 🚀 Features

- 🔐 Firebase Authentication (Email/Password)
- 🌗 Light/Dark Mode Toggle (Persists across app restarts)
- 📋 Task Management (Add, update, delete, mark complete)
- ⏱ Real-time updates via Firestore
- ✅ Dashboard shows:
  - Completed tasks (horizontally scrollable)
  - Ongoing tasks (list)
- 🔍 Task Details View
- 🎨 Beautiful animations using `flutter_animate`

---

## 🛠 Setup Instructions

1. **Clone the Repo**

   ```bash
   git clone https://github.com/Siddiqui145/mini_task_hub.git
   cd mini_task_hub
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup (see below)**

4. **Run the App**

   ```bash
   flutter run
   ```

---

## 🔥 Firebase Setup

1. Go to [https://console.firebase.google.com](https://console.firebase.google.com)

2. Create a new Firebase project.

3. **Add Firebase to your Flutter app:**
   - Click on **Add App** → Choose **Android** or **iOS**
   - Use your app's package name (e.g., `com.mini_task_hub.apps`)
   - Download the `google-services.json` or `GoogleService-Info.plist` and:
     - Android: place it in `android/app/`
     - iOS: place it in `ios/Runner/`

4. In the Firebase console:
   - Enable **Authentication** → Email/Password Sign-in
   - Go to **Firestore Database** → Create Database (start in test mode)
   - Create a collection named `tasks`

5. Enable Firebase in Flutter:
   ```dart
   await Firebase.initializeApp();
   ```

---

## ⚙️ Project Structure

```
lib/
│
├── auth/                → Login screen
├── dashboard/           → Dashboard & Task Detail UI
├── providers/cubit/     → Bloc-based State Management (theme, tasks)
├── widgets/             → Reusable components (e.g., TaskCard)
└── main.dart            → App entry point
```

---

## 🔄 Hot Reload vs Hot Restart

| Feature       | Hot Reload                                | Hot Restart                              |
|---------------|--------------------------------------------|-------------------------------------------|
| Speed         | 🔥 Very fast                              | 🌀 Slower than reload                      |
| State         | ❌ Keeps app state                        | ✅ Resets app state                        |
| Code Changes  | ✅ UI & logic changes                     | ✅ UI, logic & app initialization          |
| Use When      | Tweak UI or logic                        | Modify `main.dart`, themes, or globals    |

- Use **hot reload** when modifying widgets or minor logic.
- Use **hot restart** when changing `initState`, app themes, or Firebase initialization.

---

## 📸 Demo

https://github.com/user-attachments/assets/d59a5161-d07f-4848-90fe-852b525e3e7e

---

## 📦 Packages Used

- `firebase_core`  
- `firebase_auth`  
- `cloud_firestore`  
- `flutter_bloc`  
- `flutter_animate`  
- `intl`  
- `shared_preferences` (optional for theme persistence)

---

## ✨ Coming Soon

- 🔔 Notifications for task deadlines  
- 🗂 Filter/sort options  
- 👥 Team collaboration features  

---

## 🙌 Contributions

Feel free to fork, submit issues, or create pull requests. PRs with tests and proper commit messages are appreciated!

---

## 📝 License

MIT © [Taha Siddiqui](https://github.com/Siddiqui145)
