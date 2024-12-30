import 'package:either_dart/either.dart';
import 'package:rick_morty_bloc/data/api_services/errors.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_contract.dart';
import 'package:rick_morty_bloc/data/repository/characters/repository/characters_repo_contract.dart';

class CharactersRepositoryImpl implements CharactersRepositoryContract {
  CharactersRemoteDataSourceContract remoteContract;

  CharactersRepositoryImpl({required this.remoteContract});

  @override
  Future<Either<Errors, CharactersResponse?>> getAllCharacters({int page = 1}) {
    return remoteContract.getAllCharacters(page: page);
  }
}
