import 'package:rick_morty_bloc/data/api_services/api_manager.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_delegate.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_impl.dart';

//* viewModel => object Repository

//* Repository => object DataSource

CharactersRemoteDataSourceDelegate injectCharactersRemoteDataSourceDelegate() {
  return CharactersRemoteDataSourceImpl(apiManager: injectApiManager());
}

//* DataSource => object ApiManager
ApiManager injectApiManager() {
  return ApiManager();
}
