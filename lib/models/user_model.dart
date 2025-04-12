import 'dart:convert';

class UserModel {
  final User user;
  final String token;

  UserModel({
    required this.user,
    required this.token,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        token: json["token"] ?? '',
      );

  factory UserModel.empty() => UserModel(
        user: User.empty(),
        token: '',
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(false),
        "token": token,
      };

  String toRawJson() => json.encode(toJson());

  UserModel copyWith({User? user, String? token}) {
    return UserModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'UserModel{user: $user, token: $token}';
  }
}

class User {
  final String userName;
  final String password;
  final String stk;
  final String hoTen;
  final String code;

  User({
    required this.userName,
    required this.password,
    required this.stk,
    required this.hoTen,
    required this.code,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json["username"] ?? '',
        password: json["password"] ?? '',
        stk: json["stk"] ?? '',
        hoTen: json["ho_ten"] ?? '',
        code: '',
      );

  factory User.empty() => User(
        userName: '',
        password: '',
        stk: '',
        hoTen: '',
        code: '',
      );

  Map<String, dynamic> toJson(bool isPincode) => {
        "username": userName,
        "password": password,
        "stk": stk,
        "ho_ten": hoTen,
        "pin_code": isPincode ? "" : code,
      };

  @override
  String toString() {
    return 'UserModel{userName: $userName, password: $password, stk: $stk, hoTen: $hoTen, code: $code}';
  }

  User copyWith(
      {String? userName,
      String? password,
      String? stk,
      String? hoTen,
      String? code}) {
    return User(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      stk: stk ?? this.stk,
      hoTen: hoTen ?? this.hoTen,
      code: code ?? this.code,
    );
  }
}
