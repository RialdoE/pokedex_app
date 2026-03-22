# PokéDex App

A cross-platform Flutter application that allows users to browse and explore Pokémon data using the PokéAPI, with Firebase authentication and a favouriting system.

---

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile framework |
| Dart | Programming language |
| Firebase Auth | User authentication |
| Cloud Firestore | Storing user favourites |
| PokéAPI | Pokémon data source |
| Flutter Bloc / Cubit | State management |
| SharedPreferences | Persisting theme preference |

---

## Features

- 🔐 Email/password authentication (register and login)
- 📋 Paginated list of all Pokémon fetched from PokéAPI
- 🔍 Search Pokémon by name with autocomplete suggestions
- 📖 Detail page showing full image, description, stats and types
- ❤️ Favourite Pokémon from home or detail page, stored per user in Firestore
- 🔥 Filter home page to show only favourited Pokémon
- 🌙 Light and dark mode with persistent preference
- ✅ Unit and widget tests

---

## Architecture

The app follows a clean architecture pattern with clear separation between layers:

- **UI Layer** — Flutter pages and widgets
- **Business Logic Layer** — Cubits (`PokemonCubit`, `FavouriteCubit`)
- **Data Layer** — Repositories (`PokemonRepository`, `FavouriteRepository`)

### State Management
Cubit (part of the Flutter Bloc library) is used for state management. Each feature has its own cubit and state file keeping the code modular and maintainable.

### Repository Pattern
All data fetching is handled through repositories. The `PokemonRepository` handles all PokéAPI calls and the `FavouriteRepository` handles all Firestore operations.

---

## Setup Instructions

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) installed
- Android Studio or Xcode installed
- A connected device or emulator

### Installation
```bash
# Clone the repository
git clone https://github.com/RialdoE/pokedex_app.git

# Navigate into the project
cd pokedex_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Running Tests
```bash
flutter test
```

---

## API Keys

This repository is public and contains `firebase_options.dart` which includes Google API keys. These keys are **restricted** at the Google Cloud Console level:

- **Application restrictions** — keys are restricted to this specific app only
- **API restrictions** — keys are limited to only the Firebase services this app uses

The keys are effectively useless to anyone attempting to use them outside of this application.

---

## Author

**Rialdo Erasmus**
[GitHub](https://github.com/RialdoE)
