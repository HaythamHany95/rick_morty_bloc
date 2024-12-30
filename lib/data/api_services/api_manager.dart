import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:rick_morty_bloc/data/api_services/api_endpoints.dart';
import 'package:rick_morty_bloc/data/api_services/errors.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    BaseOptions options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<Either<Errors, CharactersResponse>> getAllCharacters(
      {int page = 1}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return Left(NetworkError(errorMessage: 'No internet connection'));
    }

    try {
      Response response = await dio.get(
        '${EndPoints.getCharacters}?page=$page',
      );
      var charactersResponse = CharactersResponse.fromJson(response.data);
      return Right(charactersResponse);
    } catch (error) {
      return Left(ServerError(errorMessage: error.toString()));
    }
  }
}
