import 'package:rick_morty_bloc/data/models/characters_response.dart';

abstract class CharactersRemoteDataSourceContract {
  Future<CharactersResponse?> getAllCharacters({int page = 1});
}
