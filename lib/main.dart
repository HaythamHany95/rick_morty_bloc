import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_morty_bloc/core/router/app_router.dart';
import 'package:rick_morty_bloc/data/models/character.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  await Hive.openBox<Character>('favorites');
  runApp(RickAndMortyApp(appRoute: AppRouter()));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRouter appRoute;

  const RickAndMortyApp({super.key, required this.appRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.onGenerateRoute,
    );
  }
}
