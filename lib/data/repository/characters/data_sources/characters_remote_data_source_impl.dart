import 'package:either_dart/either.dart';
import 'package:rick_morty_bloc/data/api_services/api_manager.dart';
import 'package:rick_morty_bloc/data/api_services/errors.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:rick_morty_bloc/data/repository/characters/data_sources/characters_remote_data_source_contract.dart';

class CharactersRemoteDataSourceImpl
    implements CharactersRemoteDataSourceContract {
  ApiManager apiManager;

  CharactersRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Errors, CharactersResponse?>> getAllCharacters(
      {int page = 1}) async {
    var either = await apiManager.getAllCharacters(page: page);
    return either.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }
}
