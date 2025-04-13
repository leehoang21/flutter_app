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
      logInfo(LoggerInfo(response.request, "signUp request"));
      logInfo(LoggerInfo(user.toJson(true), "signUp request body"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var userModel = UserModel.fromRawJson(response.body);
        userModel = userModel.copyWith(
            user: userModel.user.copyWith(
          password: user.password,
        ));
        logInfo(LoggerInfo(userModel, "signUp response"));

        await localStorage.writeUser(userModel);
        return (
          userModel,
          null,
        );
      } else {
        logError(LoggerInfo(response, "signUp response"));
        return (
          UserModel(user: User.empty(), token: ''),
          ErrorModel.fromRawJson(response.body),
        );
      }
    } on Exception catch (e) {
      logError(LoggerInfo(e, "signUp request"));
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
      final body = {
        'username': username,
        'password': password,
      };
      final response = await client.post(
        uri,
        body: body,
      );
      logInfo(LoggerInfo(response.request, "signIn request"));
      logInfo(LoggerInfo(body, "signIn request body"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var userModel = UserModel.fromRawJson(response.body);

        userModel = userModel.copyWith(
            user: userModel.user.copyWith(
          password: password,
        ));
        logInfo(LoggerInfo(userModel, "signIn response"));
        await localStorage.writeUser(userModel);
        return (
          userModel,
          null,
        );
      } else {
        logError(LoggerInfo(response, "signIn response"));
        return (
          UserModel(user: User.empty(), token: ''),
          ErrorModel.fromRawJson(response.body),
        );
      }
    } on Exception catch (e) {
      logError(LoggerInfo(e, "signIn request"));
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
      logInfo(LoggerInfo(response.request, "changePassword request"));
      logInfo(LoggerInfo(headers, "changePassword request header "));
      logInfo(LoggerInfo({
        "newPassword": password,
      }, "changePassword request body"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //notification
        serviceApp?.notificationConfig.show(Notification(
          title: 'Đổi mật khẩu thành công',
          body: '${user.user.password} -> $password',
        ));
        //save
        logInfo(LoggerInfo(user, "changePassword response"));
        await localStorage.writeUser(user.copyWith(
            user: user.user.copyWith(
          password: password,
        )));
        return null;
      } else {
        logError(LoggerInfo(response, "changePassword response"));
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
      logError(LoggerInfo(e, "changePassword request"));
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
      logInfo(LoggerInfo(response.request, "changePincode request"));
      logInfo(LoggerInfo(headers, "changePincode request header "));
      logInfo(LoggerInfo({
        "newPinCode": pin,
      }, "changePincode request body"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //save
        logInfo(LoggerInfo(response, "changePincode response"));
        return null;
      } else {
        logError(LoggerInfo(response, "changePincode response"));
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
      logError(LoggerInfo(e, "changePincode request"));
      return ErrorModel(
        message: e.toString(),
      );
    }
  }
}
