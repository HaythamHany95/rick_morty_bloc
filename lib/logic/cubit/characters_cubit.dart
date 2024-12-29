import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/logic/cubit/characters_state.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_contract.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  CharactersRepositoryContract repoContract;

  CharactersCubit({required this.repoContract}) : super(CharactersInitial());
  List<Character> characters = [];
  List<Character> searchedCharacters = [];
  bool searching = false;
  var searchController = TextEditingController();

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  void getAllCharacters() async {
    if (currentPage == 1) {
      emit(CharactersInitial());
    }

    if (!hasMoreData || isLoading) return;

    isLoading = true;
    var response = await repoContract.getAllCharacters(page: currentPage);
    isLoading = false;

    if (response?.error == null) {
      if (currentPage == 1) {
        characters = response?.results ?? [];
      } else {
        characters.addAll(response?.results ?? []);
      }

      hasMoreData = response?.info?.next != null;
      currentPage++;
      emit(CharactersSuccessState(characters: characters));
    }
  }

  void resetPagination() {
    currentPage = 1;
    hasMoreData = true;
    characters = [];
    searchedCharacters = [];
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
