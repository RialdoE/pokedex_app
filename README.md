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

- Email/password authentication (register and login)
- Paginated list of all Pokémon fetched from PokéAPI
- Search Pokémon by name with autocomplete suggestions
- Detail page showing full image, description, stats and types
- Favourite Pokémon from home or detail page, stored per user in Firestore
- Filter home page to show only favourited Pokémon
- Light and dark mode with persistent preference
- Unit and widget tests

---

## Architecture

I used the Bloc/Cubit pattern with repositories to separate the UI, business logic and data layers.
The PokemonRepository handles the API calls from PokéAPI and the FavouriteRepository handles connection to the database.

---

## Setup Instructions

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) installed
- Android Studio or Xcode installed
- A connected device or emulator

### How to run
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

## Note on API Keys

The firebase_options.dart file is included in the repo but the API keys are restricted in Google Cloud Console to only work with this specific app.

---

## Author

**Rialdo Erasmus**
[GitHub](https://github.com/RialdoE)
