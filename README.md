Rick and Morty Characters Explorer
This project is a Flutter-based application designed to explore characters from the Rick and Morty API.

Features
Data Retrieval & Display: Fetches and displays character details from the Rick and Morty API.
Search & Filtering: Enables search functionality and filters characters by status and species.
Pagination: Implements infinite scrolling for smooth data loading.
Favorites Management: Allows users to save favorite characters using Hive for local storage.
Character Detail Screen: Displays detailed information, including episodes.
Error Handling: Provides user-friendly error messages and loading indicators.
State Management: Built using Bloc for predictable state handling.
Clean Architecture: Ensures modularity and maintainability.
Project Structure
The project follows a feature-first structure with Clean Architecture principles:

lib/  
├── core/  
├── data/  
│   ├── api_services/  
│   ├── models/  
│   └── repository/  
├── logic/  
│   └── cubit/  
│       ├── characters_cubit.dart  
│       └── characters_state.dart  
├── presentation/  
│   ├── screens/  
│   └── widgets/  
├── dep_injection.dart  
└── main.dart  


Dependencies:
connectivity_plus: ^4.0.1
cupertino_icons: ^1.0.6
hive: ^2.2.3
hive_flutter: ^1.1.0
dio: ^5.4.3+1
either_dart: ^1.0.0
Rick and Morty API

