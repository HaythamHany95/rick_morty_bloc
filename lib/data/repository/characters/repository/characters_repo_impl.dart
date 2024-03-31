import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_delegate.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_delegate.dart';

class CharactersRepositoryImpl implements CharactersRepositoryDelegate {
  CharactersRemoteDataSourceDelegate remoteDelegate;

  CharactersRepositoryImpl({required this.remoteDelegate});

  @override
  Future<CharactersResponse?> getAllCharacters() {
    return remoteDelegate.getAllCharacters();
  }
}
