import 'package:rick_morty_bloc/data/api_services/api_manager.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_delegate.dart';

class CharactersRemoteDataSourceImpl
    implements CharactersRemoteDataSourceDelegate {
  ApiManager apiManager;

  CharactersRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<CharactersResponse?> getAllCharacters() async {
    var response = await apiManager.getCharacters();
    return response;
  }
}
