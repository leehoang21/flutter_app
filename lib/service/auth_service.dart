import 'package:flutter_app/common/extension.dart';
import 'package:flutter_app/common/local_storage.dart';
import 'package:flutter_app/common/log.dart';
import 'package:http/http.dart' as http;

import '../common/contant.dart';
import '../common/notification_config.dart';
import '../models/error_model.dart';
import '../models/user_model.dart';
import '../presentation/routes.dart';

class AuthService {
  final http.Client client;
  final LocalStorage localStorage;

  AuthService(this.client, this.localStorage);

  Future<(UserModel, ErrorModel?)> signUp(User user) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/sign_up');
      final response = await client.post(
        uri,
        body: user.toJson(true),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var userModel = UserModel.fromRawJson(response.body);
        userModel = userModel.copyWith(
            user: userModel.user.copyWith(
          password: user.password,
        ));
        await localStorage.writeUser(userModel);
        return (
          userModel,
          null,
        );
      } else {
        logError(response.body);
        return (
          UserModel(user: User.empty(), token: ''),
          ErrorModel.fromRawJson(response.body),
        );
      }
    } on Exception catch (e) {
      logError(e);
      return (
        UserModel(user: user, token: ''),
        ErrorModel(
          message: e.toString(),
        ),
      );
    }
  }

  Future<(UserModel, ErrorModel?)> signIn(
      String username, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/login');
      final response = await client.post(
        uri,
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var userModel = UserModel.fromRawJson(response.body);

        userModel = userModel.copyWith(
            user: userModel.user.copyWith(
          password: password,
        ));
        await localStorage.writeUser(userModel);
        return (
          userModel,
          null,
        );
      } else {
        logError(response.body);
        return (
          UserModel(user: User.empty(), token: ''),
          ErrorModel.fromRawJson(response.body),
        );
      }
    } on Exception catch (e) {
      logError(e);
      return (
        UserModel(user: User.empty(), token: ''),
        ErrorModel(
          message: e.toString(),
        ),
      );
    }
  }

  Future<ErrorModel?> changePassword(String password) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/change_pass');
      final user = localStorage.readUser;
      if (user == null) {
        return ErrorModel(
          message: 'User not found',
        );
      }
      final headers = {
        'Authorization': 'Bearer ${user.token}',
      };
      final response = await client.post(
        uri,
        body: {
          "newPassword": password,
        },
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        //notification
        serviceApp?.notificationConfig.show(Notification(
          title: 'Đổi mật khẩu thành công',
          body: '${user.user.password} -> $password',
        ));
        //save
        await localStorage.writeUser(user.copyWith(
            user: user.user.copyWith(
          password: password,
        )));
        return null;
      } else {
        logError(response.body);
        final e = ErrorModel.fromRawJson(response.body);
        if (e.message == "Token không hợp lệ") {
          localStorage.removeUser();
          localStorage.removeTransactions();
          navigator.currentContext!.pushAndRemoveUntil(RouteList.loginScreen);
          return ErrorModel(
            message: 'Token không hợp lệ',
          );
        }
        return e;
      }
    } on Exception catch (e) {
      logError(e);
      return ErrorModel(
        message: e.toString(),
      );
    }
  }

  Future<ErrorModel?> changePin(String pin) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/change_pin_code');
      final user = localStorage.readUser;
      if (user == null) {
        return ErrorModel(
          message: 'User not found',
        );
      }
      final headers = {
        'Authorization': 'Bearer ${user.token}',
      };
      final response = await client.post(
        uri,
        body: {
          "newPinCode": pin,
        },
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        logError(response.body);
        final e = ErrorModel.fromRawJson(response.body);
        if (e.message == "Token không hợp lệ") {
          localStorage.removeUser();
          localStorage.removeTransactions();
          navigator.currentContext!.pushAndRemoveUntil(RouteList.loginScreen);
          return ErrorModel(
            message: 'Token không hợp lệ',
          );
        }
        return e;
      }
    } on Exception catch (e) {
      logError(e);
      return ErrorModel(
        message: e.toString(),
      );
    }
  }
}
