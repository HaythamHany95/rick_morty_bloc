// ignore_for_file: use_rethrow_when_possible, avoid_print

import 'package:dio/dio.dart';
import 'package:rick_morty_bloc/constants/api_constants.dart';
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

  Future<CharactersResponse?> getAllCharacters() async {
    try {
      Response response = await dio.get(ApiConstant.charactersEndPoint);
      var charactersResponse = CharactersResponse.fromJson(response.data);
      return charactersResponse;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
