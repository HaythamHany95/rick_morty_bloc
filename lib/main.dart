import 'package:flutter/material.dart';
import 'package:rick_morty_bloc/presentation/widgets/router/app_router.dart';

void main() {
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
