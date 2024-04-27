import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/business_logic/cubit/characters_state.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_delegate.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  CharactersRepositoryDelegate repoDelegate;

  CharactersCubit({required this.repoDelegate}) : super(CharactersInitial());
  List<Character> characters = [];
  List<Character> searchedCharacters = [];
  bool searching = false;
  var searchController = TextEditingController();

  void getAllCharacters() async {
    var response = await repoDelegate.getAllCharacters();
    if (response?.error == null) {
      characters = response?.results ?? [];
      emit(CharactersSuccessState(characters: characters));
    }
  }

  void addCharacterToSearchedList(String searchText) {
    searchedCharacters = characters
        .where(
            (character) => character.name!.toLowerCase().startsWith(searchText))
        .toList();
    emit(CharacterSearchState());
  }

  void emitSearchState() {
    emit(CharacterSearchState());
  }
}
