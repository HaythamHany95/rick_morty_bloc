// ignore_for_file: use_rethrow_when_possible

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_morty_bloc/constants/api_constants.dart';
import 'package:rick_morty_bloc/data/models/characters_response.dart';

class CharactersApiManager {
  static Future<CharactersResponse?> getCharacters() async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.charactersEndPoint);
    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      return CharactersResponse.fromJson(jsonData);
    } catch (error) {
      throw error;
    }
  }
}
