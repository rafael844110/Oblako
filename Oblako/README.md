# Oblako — Professional Chef Booking App

## Overview

Oblako is a mobile application that connects users with professional chefs for events, private dining, and culinary experiences. Browse chefs, view their profiles and menus, and book them directly through the app.

## Features

- Browse and search professional chefs
- View chef profiles, specializations, and menus
- Browse recipes
- User and chef account registration
- Firebase-backed authentication and data storage
- Chef and user profile management

## Tech Stack

- **Flutter** (Dart)
- **Firebase Auth** — email/password authentication
- **Cloud Firestore** — user and chef profile storage
- **BLoC / Cubit** — state management
- **Auto Route** — navigation
- **GetIt** — dependency injection

## Project Structure

```
lib/
├── core/
│   ├── data/           # Services, mock DB, bottom bar config
│   ├── di/             # Dependency injection (injections.dart)
│   ├── navigation/     # App router + route guards
│   ├── theme/          # App theme, colors, text styles
│   ├── utils/          # Constants, helpers, snackbars
│   └── widgets/        # Shared UI components
├── features/
│   ├── authentication/ # Login, signup, auth cubit
│   ├── chef/           # Chef listing, details, cubit
│   ├── home/           # Home page, categories, banners
│   ├── profile/        # User/chef profile management
│   └── recipe/         # Recipe listing and details
├── firebase_options.dart
└── main.dart
```

---

## Setup Guide

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.5.3
- Dart >= 3.5.3
- Xcode (for iOS) or Android Studio (for Android)
- A Firebase project

### 1. Clone the repository

```bash
git clone https://github.com/rafael844110/Oblako.git
cd Oblako
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Firebase setup

This app requires a Firebase project with **Authentication** and **Firestore** enabled.

#### 3a. Create a Firebase project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project (or use existing)
3. Enable **Email/Password** under Authentication → Sign-in method
4. Create a **Firestore Database** (start in production mode)

#### 3b. Configure Firestore security rules

In Firestore → Rules, set:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

#### 3c. Add Firebase config files

**iOS:** Download `GoogleService-Info.plist` from Firebase Console → Project Settings → iOS app and place it at:
```
ios/Runner/GoogleService-Info.plist
```

**Android:** Download `google-services.json` and place it at:
```
android/app/google-services.json
```

#### 3d. Update firebase_options.dart

Run FlutterFire CLI to regenerate `lib/firebase_options.dart` for your project:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Or manually update `lib/firebase_options.dart` with your project's API keys from Firebase Console → Project Settings → Your apps.

### 4. iOS — install CocoaPods

```bash
cd ios
pod install
cd ..
```

### 5. Run the app

```bash
# List available devices
flutter devices

# Run on a specific device
flutter run -d <device-id>

# Run on iOS simulator
flutter run -d iphone

# Run on Android emulator
flutter run -d android
```

### 6. Build for release

```bash
# Android App Bundle (for Play Store)
flutter build appbundle

# iOS archive (for App Store)
flutter build ipa
```

Output locations:
- Android: `build/app/outputs/bundle/release/app-release.aab`
- iOS: `build/ios/archive/Runner.xcarchive`

---

## Firestore Data Structure

```
chefs/{uid}
  id, name, email, role, phoneNumber, avatar, createdAt, profile, chefDetails

users/{uid}
  id, name, email, role, phoneNumber, avatar, createdAt
```

---

## Contact

Rafael Dzhumagulov - rdzhuma1@stu.vistula.edu.pl


