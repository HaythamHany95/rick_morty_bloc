import 'package:flutter/material.dart';
import 'package:rick_morty_bloc/presentation/screens/character_details_screen.dart';
import 'package:rick_morty_bloc/presentation/screens/characters_screen.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CharactersScreen.routeName,
      routes: {
        CharactersScreen.routeName: (_) => CharactersScreen(),
        CharacterDetailsScreen.routeName: (_) => const CharacterDetailsScreen(),
      },
    );
  }
}
