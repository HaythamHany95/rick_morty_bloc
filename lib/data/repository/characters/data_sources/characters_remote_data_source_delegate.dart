import 'package:rick_morty_bloc/data/models/characters_response.dart';

abstract class CharactersRemoteDataSourceDelegate {
  Future<CharactersResponse?> getAllCharacters();
}
