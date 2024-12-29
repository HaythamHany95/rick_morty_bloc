import 'package:rick_morty_bloc/data/api_services/errors.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

abstract class CharactersStates {}

class CharactersInitial extends CharactersStates {}

class CharactersLoadingState extends CharactersStates {}

class CharactersErrorState extends CharactersStates {
  Errors errorMessage;

  CharactersErrorState({required this.errorMessage});
}

class CharactersSuccessState extends CharactersStates {
  List<Character?> characters;

  CharactersSuccessState({required this.characters});
}
