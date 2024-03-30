import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_bloc/business_logic/cubit/characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharactersInitial());
}
