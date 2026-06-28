<div align="center">

# Flutter Boilerplate

**A production-ready Flutter starter template for senior-level applications.**

[![CI](https://github.com/your-username/flutter_boilerplate/actions/workflows/ci.yml/badge.svg)](https://github.com/your-username/flutter_boilerplate/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.11.5+-02569B?logo=flutter)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/GetX-4.6.6-blueviolet)](https://pub.dev/packages/get)

Built with Clean Architecture, GetX, Dio, Firebase, Material 3 theming, localization, and GitHub Actions CI/CD. Clone it once — use it forever.

</div>

---

## Why This Boilerplate?

Starting a Flutter project from scratch means making the same decisions every time: architecture, state management, networking, error handling, theming, localization, storage, and CI/CD. This boilerplate makes those decisions once, correctly, so you can focus on shipping features from day one.

---

## Features

| Category | Implementation |
|---|---|
| Architecture | Feature-first Clean Architecture (Data / Domain / Presentation) |
| State Management | GetX — controllers, `.obs` reactivity, bindings |
| Dependency Injection | GetX bindings with lazy registration |
| Networking | Dio with Auth, Error, and Logging interceptors |
| Local Storage | GetStorage (persisted across restarts) |
| Navigation | GetX named routes with per-route bindings |
| Theming | Material 3, light/dark mode, persisted user preference |
| Localization | ARB-based (English, Hindi, Spanish), persisted language |
| Firebase | Core, Auth, Firestore, Analytics, Crashlytics, Messaging |
| Error Handling | Typed `Exception` and `Failure` hierarchy per layer |
| Validation | Centralised `Validators` class reused across all forms |
| Testing | Unit tests, `UserModel` tests, mock repository |
| CI/CD | GitHub Actions — analyze, test, build APK and iOS |
| Environment | `dotenv` for secrets, `.env.example` committed as template |

---

## Architecture Overview

This project follows **Feature-first Clean Architecture**. Each feature is fully self-contained and isolated. Business logic never touches the UI.

```
UI (Page)
   ↓
Controller  (GetX — presentation layer)
   ↓
Use Case    (domain layer — single responsibility)
   ↓
Repository  (domain interface / data implementation)
   ↓
DataSource  (remote: Dio API  |  local: GetStorage)
```

### Folder Structure

```
lib/
├── core/
│   ├── config/           # EnvConfig — centralised dotenv access
│   ├── constants/        # AppConstants, AppSpacing
│   ├── error/            # Exceptions (data layer) & Failures (domain layer)
│   ├── network/          # ApiClient, ApiResponse, interceptors/
│   │   └── interceptors/ # AuthInterceptor, ErrorInterceptor, LoggingInterceptor
│   ├── storage/          # StorageService (GetStorage wrapper)
│   ├── theme/            # AppTheme, AppColors, AppTextStyles
│   └── utils/            # Validators, Extensions, ConnectivityService
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/   # AuthRemoteDataSource, AuthLocalDataSource
│   │   │   ├── models/        # UserModel (extends UserEntity)
│   │   │   └── repositories/  # AuthRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/      # UserEntity
│   │   │   ├── repositories/  # AuthRepository (abstract)
│   │   │   └── usecases/      # LoginUseCase, RegisterUseCase, LogoutUseCase
│   │   └── presentation/
│   │       ├── controllers/   # AuthController, AuthBinding
│   │       ├── pages/         # SplashPage, LoginPage, RegisterPage
│   │       └── widgets/       # AuthTextField
│   │
│   ├── home/
│   │   └── presentation/      # HomeController, HomeBinding, HomePage
│   │
│   └── settings/
│       └── presentation/      # SettingsController, SettingsBinding, SettingsPage
│
├── routes/                    # AppRoutes, AppPages
├── l10n/                      # ARB files (EN, HI, ES)
├── shared/
│   └── widgets/               # AppButton, AppLogo, AppShimmer,
│                              # AppErrorWidget, AppEmptyWidget
└── main.dart
```

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) >= 3.11.5
- Dart >= 3.11.5
- A Firebase project (required for Auth, Firestore, Analytics, Crashlytics, Messaging)

### 1. Clone and install

```bash
git clone https://github.com/your-username/flutter_boilerplate.git
cd flutter_boilerplate
flutter pub get
```

### 2. Configure environment

```bash
cp .env.example .env
```

Open `.env` and set your values:

```env
API_BASE_URL=https://api.your-domain.com
API_TIMEOUT=30000
APP_ENV=development
```

### 3. Configure Firebase

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This replaces `lib/firebase_options.dart` with your project's real values.

### 4. Add Poppins font (optional but recommended)

Download [Poppins](https://fonts.google.com/specimen/Poppins) and place the `.ttf` files in `assets/fonts/`. Then uncomment the `fonts` block in `pubspec.yaml`.

### 5. Run

```bash
flutter run
```

---

## Environment Variables

| Key | Default | Description |
|---|---|---|
| `API_BASE_URL` | `https://api.example.com` | Base URL for all HTTP requests |
| `API_TIMEOUT` | `30000` | Request/response timeout (ms) |
| `APP_ENV` | `production` | Set to `development` to enable debug logs |

> Never commit `.env` with real credentials. Only `.env.example` is tracked by git.

---

## Running Tests

```bash
# All tests
flutter test

# With coverage report
flutter test --coverage

# Specific folder
flutter test test/unit/
```

Tests are located in:

```
test/
├── unit/
│   ├── validators_test.dart   # 8 test cases
│   └── user_model_test.dart   # 6 test cases
└── mocks/
    └── mock_auth_repository.dart
```

---

## CI/CD

Two GitHub Actions workflows are included out of the box.

### `ci.yml` — runs on every push and pull request

1. Install dependencies
2. Check formatting (`dart format`)
3. Static analysis (`flutter analyze`)
4. Run all tests
5. Upload coverage to Codecov

### `build.yml` — runs on version tags (`v*`)

1. Build release APK (Android)
2. Build iOS (no-codesign)
3. Upload APK as a build artifact

To trigger a release build:

```bash
git tag v1.0.0
git push origin v1.0.0
```

---

## Adding a New Feature

Follow these steps to keep the architecture consistent:

```
1. Create lib/features/<feature_name>/
   ├── data/
   │   ├── datasources/
   │   ├── models/
   │   └── repositories/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/   ← abstract interface
   │   └── usecases/
   └── presentation/
       ├── controllers/    ← GetX controller + binding
       ├── pages/
       └── widgets/

2. Register the route in lib/routes/app_pages.dart
3. Write unit tests in test/unit/<feature_name>/
```

**Rules to follow:**

- Business logic belongs in use cases and repositories, never in widgets.
- Controllers depend on use cases, not on datasources directly.
- Every async operation must handle loading, success, error, and empty states.
- Use `AppColors`, `AppTextStyles`, and `AppSpacing` — never hardcode values.

---

## Shared Widgets

| Widget | Description |
|---|---|
| `AppButton` | Filled, outlined, and text variants with loading state |
| `AppLogo` | Branded icon mark, configurable size |
| `AppShimmer` | Shimmer loading wrapper + `ShimmerBox` placeholder |
| `AppErrorWidget` | Full-screen error with optional retry button |
| `AppEmptyWidget` | Full-screen empty state with icon and subtitle |

---

## Tech Stack

| Package | Purpose |
|---|---|
| [get](https://pub.dev/packages/get) | State management, DI, routing |
| [get_storage](https://pub.dev/packages/get_storage) | Persistent local storage |
| [dio](https://pub.dev/packages/dio) | HTTP client |
| [firebase_core](https://pub.dev/packages/firebase_core) | Firebase initialisation |
| [firebase_auth](https://pub.dev/packages/firebase_auth) | Authentication |
| [cloud_firestore](https://pub.dev/packages/cloud_firestore) | Database |
| [firebase_analytics](https://pub.dev/packages/firebase_analytics) | Event tracking |
| [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) | Crash reporting |
| [firebase_messaging](https://pub.dev/packages/firebase_messaging) | Push notifications |
| [dartz](https://pub.dev/packages/dartz) | `Either` for functional error handling |
| [equatable](https://pub.dev/packages/equatable) | Value equality for entities |
| [shimmer](https://pub.dev/packages/shimmer) | Skeleton loading effect |
| [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) | Environment variable loading |
| [connectivity_plus](https://pub.dev/packages/connectivity_plus) | Network state detection |
| [logger](https://pub.dev/packages/logger) | Structured debug logging |
| [mockito](https://pub.dev/packages/mockito) | Test mocking |

---

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

---

## License

MIT License. See [LICENSE](LICENSE) for details.
