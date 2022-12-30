import 'dart:convert';
import 'dart:developer';

import 'package:aiolosolutions/models/auth_user.dart';
import 'package:aiolosolutions/networking/api_base_helper.dart';

class AuthRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<AuthUser?> login(
      {required String email, required String password}) async {
    final response = await _helper.post(
      "api/login.php",
      jsonEncode({
        "username": email,
        "password": password,
      }),
    );
    log(response.toString(), name: 'login response');
    final AuthUser authUser = authUserFromJson(response.toString());
    return authUser;
  }
}
