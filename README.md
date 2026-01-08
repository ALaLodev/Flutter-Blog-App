# 📱 Blog App - Flutter Clean Architecture

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![BLoC](https://img.shields.io/badge/State%20Management-BLoC-blue?style=for-the-badge)

A complete and robust Blogging application built with **Flutter**, implementing **Clean Architecture** to ensure scalability, testability, and clear separation of concerns.
The backend is powered by **Supabase** (PostgreSQL + Auth + Storage).

## 📸 Screenshots

<p align="center"> 
   <img src="screenshots/signup.png" alt="SignUp Screen" width="20%" style="margin-right: 40dp"> 
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
   <img src="screenshots/login.png" alt="Login Screen" width="20%" style="margin-right: 40dp">
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
   <img src="screenshots/home.png" alt="Home Screen" width="20%" style="margin-right: 40dp"><br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
   <img src="screenshots/details.png" alt="Details Screen" width="20%">
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
   <img src="screenshots/create.png" alt="Create Screen" width="20%"> 
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
   <img src="screenshots/delete.png" alt="Delete Screen" width="20%">
<p>

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
