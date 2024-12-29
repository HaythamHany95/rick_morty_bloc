import 'package:dio/dio.dart';
import 'package:rick_morty_bloc/core/api_constants.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<CharactersResponse?> getAllCharacters({int page = 1}) async {
    try {
      Response response = await dio.get(
        '${ApiConstant.charactersEndPoint}?page=$page',
      );
      var charactersResponse = CharactersResponse.fromJson(response.data);
      return charactersResponse;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
