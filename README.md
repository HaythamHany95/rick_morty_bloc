Rick and Morty Characters Explorer
This project is a Flutter-based application designed to explore characters from the Rick and Morty API.

![WhatsApp Image 2024-12-31 at 12 07 18 AM](https://github.com/user-attachments/assets/c6d00388-75c9-45e7-bf80-46cfda7120c2)
![WhatsApp Image 2024-12-31 at 12 07 18 AM-2](https://github.com/user-attachments/assets/4db1e458-7215-480f-a5f4-f0cb5a76ba19)
![WhatsApp Image 2024-12-31 at 12 07 18 AM-3](https://github.com/user-attachments/assets/728c0d9c-4c8c-44c1-b078-1d06f1e80799)
![WhatsApp Image 2024-12-31 at 12 07 18 AM-4](https://github.com/user-attachments/assets/b9fdb6d0-0590-4e56-9266-00be717c5629)
![WhatsApp Image 2024-12-31 at 12 07 18 AM-5](https://github.com/user-attachments/assets/e80f1623-f8fb-4da1-9201-4ed369513471)
![WhatsApp Image 2024-12-31 at 12 07 18 AM-6](https://github.com/user-attachments/assets/e462dd74-782e-444c-8774-6d3e97fcfe02)

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

• connectivity_plus
• hive
• hive_flutter
• dio
• either_dart

Rick and Morty Api

