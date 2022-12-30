import 'dart:async';
import 'dart:convert';
import 'package:aiolosolutions/blocs/api_response.dart';
import 'package:aiolosolutions/models/auth_user.dart';
import 'package:aiolosolutions/repository/products_repository.dart';
import 'package:flutter/material.dart';

class AuthBloc {
  late AuthRepository _authRepository;

  late StreamController<AuthResponse<AuthUser?>> _authController;

  StreamSink<AuthResponse<AuthUser?>> get authSink => _authController.sink;

  Stream<AuthResponse<AuthUser?>> get authStream => _authController.stream;

  AuthBloc() {
    _authController = StreamController<AuthResponse<AuthUser?>>();
    _authRepository = AuthRepository();
    authSink.add(AuthResponse.initial('Login to continue'));
  }

  void login({required String email, required String password}) async {
    authSink.add(AuthResponse.initial('Fetching User'));
    try {
      AuthUser? user =
          await _authRepository.login(email: email, password: password);
      if (user != null) {
        debugPrint(jsonEncode(user.toJson()));
        authSink.add(AuthResponse.authenticated(
          user,
          user.data.token.toString(),
          user.data.refreshToken.toString(),
        ));
      } else {
        authSink.add(AuthResponse.unauthenticated(email, password));
      }
    } catch (e) {
      authSink.add(AuthResponse.error(e.toString()));

      debugPrint('$e');
    }
  }

  dispose() {
    _authController.close();
  }

  void initial() {
    authSink.add(AuthResponse.initial('Login to continue'));
  }
}
