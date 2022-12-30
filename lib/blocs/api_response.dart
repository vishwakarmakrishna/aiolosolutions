class AuthResponse<T> {
  AuthStatus? status;

  T? data;

  String? message;

  String? token;

  String? refreshToken;

  String? email;

  String? password;

  AuthResponse.initial(this.message) : status = AuthStatus.initial;

  AuthResponse.unauthenticated(this.email, this.password)
      : status = AuthStatus.unauthenticated;

  AuthResponse.authenticated(this.data, this.token, this.refreshToken)
      : status = AuthStatus.authenticated;

  AuthResponse.loading(this.message) : status = AuthStatus.loding;

  AuthResponse.error(this.message) : status = AuthStatus.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum AuthStatus { initial, authenticated, unauthenticated, loding, error }
