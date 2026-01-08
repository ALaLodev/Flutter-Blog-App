# 📱 Blog App - Flutter Clean Architecture

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![BLoC](https://img.shields.io/badge/State%20Management-BLoC-blue?style=for-the-badge)

A complete and robust Blogging application built with **Flutter**, implementing **Clean Architecture** to ensure scalability, testability, and clear separation of concerns.
The backend is powered by **Supabase** (PostgreSQL + Auth + Storage).

## 📸 Screenshots

| Login / Registro | Feed de Noticias | Detalle del Blog | Crear Post |
|:---:|:---:|:---:|:---:|:---:|:---:|
| <img src="screenshots/signup.png" width="200"/> || <img src="screenshots/login.png" width="200"/> | <img src="screenshots/home.png" width="200"/> | <img src="screenshots/detail.png" width="200"/> | <img src="screenshots/create.png" width="200"/> |<img src="screenshots/delete.png" width="200"/> |


## ✨ Key Features

* **AFull Authentication:** Sign up, login, and session persistence (the user remains logged in after closing the app).

* **Blog Management (CRUD):**
    * **Create:** Image upload to the cloud and a rich text editor with category selection.
    * **Read:** Infinite list of blog posts with automatic reading time calculation.
    * **Delete:** Secure deletion (only the post author can see and use the delete button).
* **File Uploads:** Integration with Supabase Storage for hosting cover images.
* **UI/UX:** Modern design with Dark Mode, form validations, and visual feedback (loaders, snackbars).

## 🛠️ Tech Stack

This application stands out for using enterprise-level technologies and design patterns:

* **Framework:** Flutter & Dart.
* **State Management:** **BLoC (Business Logic Component)**. xtensive use of Events and States to fully decouple business logic from the UI.
* **Architecture:** **Clean Architecture**. The codebase is strictly divided into layers:
    * *Domain:* Entities and Use Cases (pure business rules).
    * *Data:* Models, Data Sources (Supabase), and Repositories.
    * *Presentation:* BLoC, Pages, and Widgets.
* **Backend as a Service:** **Supabase**.
    * PostgreSQL database.
    * Authentication (Auth).
    * File storage (Storage Buckets).
* **IDependency Injection:** `get_it` for managing class and service instantiation.
* **Functional Programming:** `fpdart` for robust error handling using `Either<Failure, Success>`types.

## 📂 Project Structure

The project follows a feature-based modular structure:

```text
lib/
├── core/               # Shared utilities (Theme, UseCases, Errors)
├── features/
│   ├── auth/           # Authentication module
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── blog/           # Blog module
│       ├── data/
│       ├── domain/
│       └── presentation/
├── init_dependencies.dart # Dependency injection (Service Locator)
└── main.dart

```

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for full details.
---
Made with 💙 and Flutter.