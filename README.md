# Private APK Distribution System for JALDEVI HD MUSIC BOOK PROGRAM

This project provides a complete system for the private distribution of your Flutter APK, "JALDEVI HD MUSIC BOOK PROGRAM". It uses Firebase to provide a secure and easy-to-use solution for managing and distributing your app to a select audience.

## Features

- **Private, Secure Download Link:** A unique, hard-to-guess URL for downloading the APK.
- **Admin Panel:** A web-based admin panel to manage your APK, including uploading new versions, enabling/disabling downloads, regenerating the download link, and viewing download statistics.
- **Seamless User Experience:** Users on Android devices can download the APK directly without any unnecessary landing pages.
- **Always the Latest Version:** The download link always serves the latest uploaded version of your APK.
- **Secure:** The system is built with security in mind, preventing unauthorized access and directory listing.

## Technology Stack

- **Flutter:** For the admin panel web application.
- **Firebase Hosting:** To host the admin panel.
- **Firebase Authentication:** To secure the admin panel.
- **Cloud Functions for Firebase:** To handle the backend logic for APK downloads and admin actions.
- **Firebase Storage:** To store the APK file.
- **Firestore:** To store metadata about the APK and download link.

## Deployment Guide

Follow these steps to deploy and use the system:

### 1. Firebase Project Setup

1.  Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/).
2.  Add a new **Web** app to your project. You will be given a Firebase configuration object. Save this for later.
3.  Enable the following Firebase services:
    -   **Authentication:** Go to the "Authentication" section, click "Get started", and enable the "Email/Password" and/or "Google" sign-in method for your admin account.
    -   **Firestore:** Go to the "Firestore Database" section, click "Create database", and start in **production mode**.
    -   **Storage:** Go to the "Storage" section and click "Get started".
    -   **Functions:** You will set this up via the Firebase CLI.

### 2. Local Setup

1.  Install the Firebase CLI: `npm install -g firebase-tools`
2.  Log in to Firebase: `firebase login`
3.  Initialize Firebase in your project directory (the root of the file structure provided): `firebase init`
    -   Select **Hosting**, **Functions**, and **Firestore**.
    -   Choose your newly created Firebase project.
    -   **Firestore:** Use the default `firestore.rules` file.
    -   **Functions:** Choose TypeScript. Use the default for all other options.
    -   **Hosting:** Choose the `admin_panel/build/web` directory as your public directory. Configure as a single-page app.

### 3. Configure the Admin Panel

1.  Navigate to the `admin_panel` directory.
2.  Create a file `lib/firebase_options.dart` and paste the Firebase configuration from your Firebase project's web app settings. It should look like this:

    ```dart
    const firebaseOptions = {
        apiKey: "AIza....",
        authDomain: "your-project.firebaseapp.com",
        projectId: "your-project",
        storageBucket: "your-project.appspot.com",
        messagingSenderId: "...",
        appId: "1:...",
        measurementId: "G-..."
    };
    ```

### 4. Deploy the System

1.  **Deploy Functions and Rules:**
    -   From the root directory, run: `firebase deploy --only functions,firestore,storage`
2.  **Build and Deploy the Admin Panel:**
    -   Navigate to the `admin_panel` directory.
    -   Build the Flutter web app: `flutter build web`
    -   Navigate back to the root directory.
    -   Deploy the admin panel: `firebase deploy --only hosting`

### 5. Using the Admin Panel

1.  Go to your Firebase Hosting URL (you can find this in the Firebase console).
2.  Log in with the account you enabled in Firebase Authentication.
3.  You can now upload your APK, manage your download link, and monitor downloads.

## APK Upload Workflow

1.  Open your admin panel.
2.  Click the "Upload APK" button and select your compiled `JALDEVI_HD_MUSIC_BOOK_PROGRAM.apk` file.
3.  The upload will start automatically. Once complete, the new APK will be live at your private download link. The old APK is replaced.
