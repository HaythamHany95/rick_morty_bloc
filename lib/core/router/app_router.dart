import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/core/router/routes.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/dep_injection.dart';
import 'package:rick_morty_bloc/logic/cubit/characters_cubit.dart';
import 'package:rick_morty_bloc/presentation/screens/character_details_screen.dart';
import 'package:rick_morty_bloc/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersCubit _charactersCubit;

  AppRouter() {
    _charactersCubit =
        CharactersCubit(repoContract: injectCharactersRepositoryDelegate());
  }

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => _charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case Routes.characterDetailsScreen:
        final character = routeSettings.arguments as Character;

        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  character: character,
                ));
    }
    return null;
  }
}
