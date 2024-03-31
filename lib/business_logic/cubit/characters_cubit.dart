import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/business_logic/cubit/characters_state.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_delegate.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  CharactersRepositoryDelegate repoDelegate;

  CharactersCubit({required this.repoDelegate}) : super(CharactersInitial());

  void getAllCharacters() async {
    var response = await repoDelegate.getAllCharacters();
    if (response?.error == null) {
      var characters = response?.results ?? [];
      emit(CharactersSuccessState(characters: characters));
    }
  }
}
