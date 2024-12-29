import 'package:either_dart/either.dart';
import 'package:rick_morty_bloc/data/api_services/errors.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

abstract class CharactersRemoteDataSourceContract {
  Future<Either<Errors, CharactersResponse?>> getAllCharacters({int page = 1});
}
