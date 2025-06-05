# 🧩 Flutter Full-Stack User Login App

> A full-stack project with Flutter frontend and Node.js + Express backend, using MongoDB for data storage.

This project allows users to register, log in, and interact with a backend system through a Flutter frontend. It includes user management, product handling, and cart functionality.

---

## 🔧 Tech Stack

- **Frontend**: Flutter
- **Backend**: Node.js + Express
- **Database**: MongoDB
- **API Style**: REST
- **Auth**: No authentication required for now

---

## 📁 Project Structure

```
project-flutter/
├── backend/
│   ├── config/           # Database connection
│   ├── models/           # Mongoose models (User, Product, Cart)
│   ├── routes/           # Express route handlers
│   ├── uploads/          # Uploaded media or files
│   ├── .env              # Environment variables (not uploaded)
│   ├── server.js         # Entry point
│   └── package.json
├── frontend/             # Flutter app
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
```

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/flutter-user-login-app.git
cd flutter-user-login-app
```

### 2. Set up the backend

```bash
cd backend
npm install
```

Create a `.env` file based on `.env.example` and update it with your MongoDB connection string.

Then start the backend:

```bash
node server.js
```

### 3. Set up the frontend

```bash
cd ../frontend
flutter pub get
flutter run
```

> Make sure your backend server URL is configured correctly in your Flutter app (e.g., using `http://127.0.0.1:3000` for Android emulator).

## 📄 License

MIT License — use, modify, and share freely.

---

## 👨‍💻 Author

Developed by :
[Herwin Dermawan],
[Krisna Aji Nugroho],
[Nirwasita Isna Agata],
[Keiko Hana Sheika],
[Muhammad Mahasibil'Aly]
