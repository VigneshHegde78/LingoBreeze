# LingoBreeze – Save a New Word Feature

This repository contains a single-feature implementation for the LingoBreeze language-learning platform, developed in adherence to the requirements detailed in **Assignment.pdf**. The application provides a complete full-stack environment where users can save vocabulary words they want to learn later and view them in a clean, modern list interface[cite: 1].

---

## 🏗️ Project Architecture & Stack

This project strictly follows a **Feature-First Architecture** on the frontend to guarantee clean code organization, high modularity, and proper code quality[cite: 1].

*   **Frontend (`/flutter-app`)**: Developed in Flutter utilizing **Riverpod** for robust, reactive state management[cite: 1]. It handles all four essential UI states required by the specification: Loading state, Empty state, Filled state, and Error state[cite: 1].
*   **Backend (`/backend`)**: A lightweight Node.js Express application implementing the mandatory `GET /words` API endpoint used by Flutter to retrieve the language vocabulary entries[cite: 1].
*   **Database**: Powered by **Firebase Cloud Firestore** to securely store and structure vocabulary entries[cite: 1].

---

## 🚀 Getting Started

### 1. Backend Setup
1.  Navigate into the backend project directory:
```bash
    cd backend
```
2.  Install the required Node.js package dependencies:
```bash
    npm install
```
3.  Configure Firebase credentials for the backend. Set `GOOGLE_APPLICATION_CREDENTIALS` or `FIREBASE_SERVICE_ACCOUNT_KEY_PATH` to a local service account JSON file. If you keep a local copy in `backend/serviceAccountKey.json`, it will be used automatically but should not be committed.
4.  Start the local development API server:
```bash
    node index.js
```
The server will launch locally at `http://localhost:3000`.

### 2. Flutter App Setup
1.  Open a new terminal tab and navigate into the Flutter application directory:
```bash
    cd flutter-app
```
2.  Fetch all required Dart application packages:
```bash
    flutter pub get
```
3.  Launch the application on Chrome Web (or an active device emulator):
```bash
    flutter run -d chrome
```

---

## 📱 Implemented Feature Specifications

The application explicitly fulfills the expected design criteria outlined in **Assignment.pdf**[cite: 1]:

*   **Empty State**: Automatically displays the phrase "You haven't saved any words yet." alongside a styled interactive `[Add Your First Word]` button when the database collection is empty[cite: 1].
*   **Create Word Flow**: Implemented as a polished Modal Bottom Sheet containing form inputs for `Word`, `Meaning`, and `Translation`[cite: 1]. All three fields are strictly required before submission[cite: 1].
*   **Read Words**: Renders saved items in a clean, modern card layout that pulls data directly from the custom Node.js endpoint[cite: 1].
*   **Pull-to-Refresh**: An optional feature integrated into the list viewport, enabling users to trigger manual updates to the state provider[cite: 1].
*   **Loading & Error States**: Supported by stylized, user-friendly indicators to handle network requests and service disruptions elegantly[cite: 1].

---

## 🤖 Estimated AI Contribution

As requested in **Assignment.pdf**, AI development tools (such as Copilot and Gemini) were utilized to accelerate boilerplate generation and styling layout choices[cite: 1].

```text
UI/UX Layout & Polish: 70%
Backend/Express Boilerplate: 50%
Architecture & State Management: Manual Structural Setup (Riverpod)
