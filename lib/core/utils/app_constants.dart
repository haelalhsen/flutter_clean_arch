import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SharedPreferencesKeys {
  static const REGISTERD_USER = 'registered_user';
}

class Endpoints {
  static const BASE_URL = '';
  static const POKEMON_BASE_URL = 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20';
  static const IMAGE_URL = '';

  static const LOGIN = 'login';
}

final BASE_OPTIONS = BaseOptions(
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
);

final OPTION = Options(
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Accept-Language': 'en',
  },
);

class GetOptions {
  static Options options = Options();

  static Options getOptionsWithToken(String token, {String language = ''}) {
    if (token != null && token.isNotEmpty) {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
        'Accept-Language': language,
      };
    } else {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': language,
      };
    }
    return options;
  }
}
