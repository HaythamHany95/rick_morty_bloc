import 'package:dio/dio.dart';
import 'package:rick_morty_bloc/data/api_services/api_endpoints.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

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

  Future<CharactersResponse?> getAllCharacters({int page = 1}) async {
    try {
      Response response = await dio.get(
        '${EndPoints.getCharacters}?page=$page',
      );
      var charactersResponse = CharactersResponse.fromJson(response.data);
      return charactersResponse;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
