import 'dart:convert';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
  AuthUser({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  final String statusCode;
  final String status;
  final String message;
  final Data data;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  final String token;
  final String refreshToken;
  final User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        refreshToken: json["refresh_token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refresh_token": refreshToken,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.avatar,
    required this.mobile,
    required this.groupId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.gender,
    required this.dateOfBirth,
    required this.accountType,
    required this.email,
    required this.city,
    required this.firstPage,
  });

  final String id;
  final String avatar;
  final String mobile;
  final String groupId;
  final String firstName;
  final String lastName;
  final String username;
  final String gender;
  final String dateOfBirth;
  final String accountType;
  final String email;
  final String city;
  final String firstPage;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["ID"],
        avatar: json["AVATAR"],
        mobile: json["MOBILE"],
        groupId: json["GROUP_ID"],
        firstName: json["FIRST_NAME"],
        lastName: json["LAST_NAME"],
        username: json["USERNAME"],
        gender: json["GENDER"],
        dateOfBirth: json["DATE_OF_BIRTH"],
        accountType: json["ACCOUNT_TYPE"],
        email: json["EMAIL"],
        city: json["CITY"],
        firstPage: json["FIRST_PAGE"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AVATAR": avatar,
        "MOBILE": mobile,
        "GROUP_ID": groupId,
        "FIRST_NAME": firstName,
        "LAST_NAME": lastName,
        "USERNAME": username,
        "GENDER": gender,
        "DATE_OF_BIRTH": dateOfBirth,
        "ACCOUNT_TYPE": accountType,
        "EMAIL": email,
        "CITY": city,
        "FIRST_PAGE": firstPage,
      };
}
