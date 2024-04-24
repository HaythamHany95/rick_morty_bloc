import 'package:flutter/material.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

class CharacterDetailsScreen extends StatelessWidget {
  static const String routeName = 'character_details_screen';

  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var characterArgs = ModalRoute.of(context)?.settings.arguments as Character;
    return Scaffold(
      appBar: AppBar(
        title: Text(characterArgs.name ?? ""),
      ),
    );
  }
}
