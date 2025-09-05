# 🚀 Food Delivery App Setup Guide

This guide will help you set up and run the Food Delivery App on your local machine.

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0.0 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control
- **Firebase CLI** (optional, for Firebase setup)

## 🛠️ Installation Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd Food-App/mobile
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### 3.1 Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `food-delivery-app-12345`
4. Enable Google Analytics (optional)
5. Create project

#### 3.2 Configure Android App

1. In Firebase Console, click "Add app" → Android
2. Enter package name: `com.fooddelivery.app`
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### 3.3 Enable Authentication

1. Go to Authentication → Sign-in method
2. Enable Email/Password authentication
3. Enable Google Sign-in (optional)

#### 3.4 Create Firestore Database

1. Go to Firestore Database
2. Click "Create database"
3. Start in test mode
4. Choose a location close to your users

#### 3.5 Enable Storage

1. Go to Storage
2. Click "Get started"
3. Start in test mode
4. Choose a location

#### 3.6 Update Firebase Configuration

Update `lib/firebase_options.dart` with your actual Firebase configuration:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'your-android-api-key',
  appId: 'your-android-app-id',
  messagingSenderId: 'your-messaging-sender-id',
  projectId: 'your-project-id',
  storageBucket: 'your-storage-bucket',
);
```

### 4. Google Maps Setup (Optional)

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Enable Maps SDK for Android
3. Create API key
4. Add the API key to `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY" />
```

### 5. Run the App

```bash
# For Android
flutter run

# For specific device
flutter run -d <device-id>

# For release build
flutter run --release
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
FIREBASE_PROJECT_ID=your-project-id
GOOGLE_MAPS_API_KEY=your-maps-api-key
STRIPE_PUBLISHABLE_KEY=your-stripe-key
```

### Debug vs Release

- **Debug**: Uses test Firebase project and sandbox APIs
- **Release**: Uses production Firebase project and live APIs

## 📱 Demo Credentials

The app comes with pre-configured demo accounts:

### Customer Account
- **Email**: customer@demo.com
- **Password**: 123456

### Restaurant Account
- **Email**: restaurant@demo.com
- **Password**: 123456

### Rider Account
- **Email**: rider@demo.com
- **Password**: 123456

### Admin Account
- **Email**: admin@demo.com
- **Password**: 123456

## 🏗️ Project Structure

```
mobile/
├── lib/
│   ├── core/                 # Core functionality
│   │   ├── constants/        # App constants
│   │   ├── providers/        # State management
│   │   ├── routes/          # Navigation routes
│   │   ├── services/        # Firebase services
│   │   ├── theme/           # App theming
│   │   └── utils/           # Utility functions
│   ├── features/            # Feature modules
│   │   ├── auth/            # Authentication
│   │   ├── customer/        # Customer features
│   │   ├── restaurant/      # Restaurant features
│   │   ├── rider/           # Rider features
│   │   └── admin/           # Admin features
│   ├── shared/              # Shared components
│   │   ├── models/          # Data models
│   │   ├── widgets/         # Reusable widgets
│   │   └── utils/           # Shared utilities
│   └── main.dart            # App entry point
├── android/                 # Android configuration
├── assets/                  # App assets
└── pubspec.yaml            # Dependencies
```

## 🐛 Troubleshooting

### Common Issues

1. **Flutter not found**
   ```bash
   # Add Flutter to PATH
   export PATH="$PATH:/path/to/flutter/bin"
   ```

2. **Firebase connection issues**
   - Check `google-services.json` is in correct location
   - Verify Firebase project configuration
   - Check internet connection

3. **Build errors**
   ```bash
   # Clean and rebuild
   flutter clean
   flutter pub get
   flutter run
   ```

4. **Permission errors**
   - Check Android permissions in `AndroidManifest.xml`
   - Grant location permissions on device

### Getting Help

- Check Flutter documentation: https://flutter.dev/docs
- Firebase documentation: https://firebase.google.com/docs
- Create an issue in the repository

## 🚀 Deployment

### Android APK

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS (if targeting iOS)

```bash
# Build for iOS
flutter build ios --release
```

## 📝 Development Notes

- The app uses Provider for state management
- Firebase handles backend services
- Google Maps integration for location services
- Real-time updates using Firebase Realtime Database
- Push notifications via Firebase Cloud Messaging

## 🔄 Updates

To update the app:

```bash
git pull origin main
flutter pub get
flutter run
```

---

**Happy coding! 🎉**

For more information, check the main README.md file.
