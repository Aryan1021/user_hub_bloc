# User Hub BLoC

A Flutter application that displays and manages user data using the BLoC state management pattern. Built with clean architecture principles, real-time search, infinite scrolling, and optional features like pull-to-refresh, theme switching, and local post creation.

---

## 🚀 Features

- 🔁 Infinite scroll with pagination
- 🔍 Real-time search by user name
- 📃 User detail screen with posts & todos
- ➕ Add new posts locally
- ♻️ Pull-to-refresh functionality
- 🌗 Light/Dark theme switching
- ✅ Loading and error handling

---

## 🛠️ Tech Stack

| **Layer**            | **Tools/Libraries**                        |
| -------------------- | ------------------------------------------ |
| UI                   | Flutter, Material Design                   |
| Architecture         | BLoC Pattern, Clean Architecture           |
| State Management     | `flutter_bloc`, `equatable`                |
| Async Operations     | Dart `Future`, `Stream`                    |
| Dependency Injection | `get_it` (optional/extendable)             |
| Networking           | `http`, `json_serializable`, DummyJSON API |
| Local Storage        | (Optional) `shared_preferences`, `hive`    |
| Environment Config   | (Optional) `flutter_dotenv`                |
| Theme Management     | Light/Dark Mode via `ValueNotifier`        |
| Navigation           | `Navigator` with Material Routes           |


---

## 📦 Getting Started

### 1. Clone the repository
git clone https://github.com/your-username/user_hub_bloc.git
cd user_hub_bloc

### 2. Install dependencies
flutter pub get

### 3. Generate JSON serialization code
flutter pub run build_runner build --delete-conflicting-outputs

### 4. Run the app
flutter run
Make sure a device or emulator is connected.

---

## 🧭 App Overview

### 🔹 User List Screen
- Displays a list of users fetched from the DummyJSON API.
- Supports infinite scrolling with automatic pagination.
- Includes a real-time search bar to filter users by name.
- Pull-to-refresh reloads the latest users.
- Theme toggle button in the AppBar to switch between light and dark modes.

### 🔹 User Detail Screen
- Shows selected user's avatar, name, and email.
- Displays the user's posts and todos in separate sections.
- Includes a Floating Action Button (+) to create new posts.

### 🔹 Create Post Screen
- Allows the user to add a local-only post (title and body).
- The new post appears immediately at the top of the user’s post list.

---

## 🔄 Folder Structure

lib/
 ┣ blocs/               # BLoC files (UserBloc)
 ┣ models/              # Data models (User, Post, Todo)
 ┣ repositories/        # API handlers
 ┣ screens/             # UI Screens (User List, Detail, Create Post)
 ┣ widgets/             # Reusable widgets (Tile, Loader, Error)
 ┗ main.dart            # Entry point

---

## 🧩 Architecture
Uses the BLoC (Business Logic Component) pattern:
- UserRepository handles API logic
- UserBloc processes events (FetchUsers, SearchUsers) and emits states (UserLoading, UserLoaded, UserError)
- UI subscribes to BLoC states and updates accordingly

---

🌐 API Source
All data is fetched from DummyJSON API:
- Users: https://dummyjson.com/users
- Posts: https://dummyjson.com/posts/user/{userId}
- Todos: https://dummyjson.com/todos/user/{userId}

---

📄 License
This project is for assessment/demo purposes. Feel free to fork and modify.

---

Made with ❤ by Aryan 
