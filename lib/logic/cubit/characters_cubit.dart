import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/data/models/filter_characters.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_contract.dart';
import 'package:rick_morty_bloc/logic/cubit/characters_state.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  final CharactersRepositoryContract repoContract;

  CharactersCubit({required this.repoContract}) : super(CharactersInitial());

  List<Character> characters = [];
  List<Character> filteredCharacters = [];
  var searchController = TextEditingController();

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  FilterCharacters filterState = FilterCharacters();
  final List<String> statusOptions = ['Alive', 'Dead', 'unknown'];
  final List<String> speciesOptions = [
    'Human',
    'Alien',
    'Humanoid',
    'Robot',
    'Animal',
    'Disease',
    'unknown'
  ];

  Future<void> getAllCharacters() async {
    if (!hasMoreData || isLoading) return;

    // Only show loading for initial load
    if (currentPage == 1) {
      emit(CharactersLoadingState());
    }

    isLoading = true;

    var response = await repoContract.getAllCharacters(page: currentPage);

    response.fold(
      (error) {
        isLoading = false;
        emit(CharactersErrorState(errorMessage: error));
      },
      (response) {
        if (response != null) {
          if (currentPage == 1) {
            characters = response.results ?? [];
          } else {
            characters.addAll(response.results ?? []);
          }

          hasMoreData = response.info?.next != null;
          currentPage++;
          isLoading = false;

          applyFilters();
        }
      },
    );
  }

  void applyFilters() {
    filteredCharacters = characters.where((character) {
      bool matchesStatus = filterState.status == null ||
          character.status?.toLowerCase() == filterState.status?.toLowerCase();

      bool matchesSpecies = filterState.species == null ||
          character.species?.toLowerCase() ==
              filterState.species?.toLowerCase();

      bool matchesSearch = filterState.searchText.isEmpty ||
          character.name
                  ?.toLowerCase()
                  .contains(filterState.searchText.toLowerCase()) ==
              true;

      return matchesStatus && matchesSpecies && matchesSearch;
    }).toList();

    emit(CharactersSuccessState(characters: filteredCharacters));
  }

  void updateFilters({String? status, String? species, String? searchText}) {
    filterState = filterState.copyWith(
      status: status,
      species: species,
      searchText: searchText,
    );
    applyFilters();
  }

  void resetFilters() {
    filterState = FilterCharacters();
    searchController.clear();
    applyFilters();
  }

  void addCharacterToSearchedList(String searchText) {
    updateFilters(searchText: searchText);
  }

  void retry() {
    currentPage = 1;
    characters = [];
    filteredCharacters = [];
    hasMoreData = true;
    getAllCharacters();
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
