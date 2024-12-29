import 'package:rick_morty_bloc/data/api_services/api_manager.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_contract.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_impl.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_contract.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_impl.dart';

//* viewModel => object Repository
CharactersRepositoryContract injectCharactersRepositoryDelegate() {
  return CharactersRepositoryImpl(
      remoteContract: injectCharactersRemoteDataSourceDelegate());
}
//* Repository => object DataSource

CharactersRemoteDataSourceContract injectCharactersRemoteDataSourceDelegate() {
  return CharactersRemoteDataSourceImpl(apiManager: injectApiManager());
}

//* DataSource => object ApiManager
ApiManager injectApiManager() {
  return ApiManager();
}
