import 'package:rick_morty_bloc/data/models/characters_response.dart';

abstract class CharactersStates {}

class CharactersInitial extends CharactersStates {}

class CharactersSuccessState extends CharactersStates {
  List<Character?> characters;

  CharactersSuccessState({required this.characters});
}

class CharacterSearchState extends CharactersStates {}
