import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> registerUser(UserModel user);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> registerUser(UserModel user) {
    sharedPreferences.setString(
        SharedPreferencesKeys.REGISTERD_USER, json.encode(user.toJson()));
    return Future.value();
  }
}