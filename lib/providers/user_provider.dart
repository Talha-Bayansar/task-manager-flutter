import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/utillities/constants.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

final userProvider = Provider<UserProvider>((ref) => UserProvider());

class UserProvider {
  Future<dynamic> signIn(String email, String password) async {
    Response response = await Dio().post(
      '$kApiUrl/auth/local',
      data: {'identifier': email, 'password': password},
    );
    dynamic data = response.data;
    if (data['jwt'] != null) {
      SharedPrefs.instance.setString(
        'jwt',
        json.encode(
          data['jwt'],
        ),
      );
      SharedPrefs.instance.setString(
        'user',
        json.encode(
          data['user'],
        ),
      );
    }
    return data;
  }
}
