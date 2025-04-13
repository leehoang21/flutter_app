import 'dart:convert';
import 'package:flutter_app/common/extension.dart';
import 'package:flutter_app/common/local_storage.dart';
import 'package:flutter_app/common/log.dart';
import 'package:flutter_app/models/transaction_model.dart';
import 'package:flutter_app/presentation/routes.dart';
import 'package:http/http.dart' as http;

import '../common/contant.dart';
import '../models/error_model.dart';

class TransactionService {
  final http.Client client;
  final LocalStorage localStorage;

  TransactionService(this.client, this.localStorage);

  Future<(List<TransactionModel>, ErrorModel?)> get() async {
    try {
      final uri = Uri.parse('$baseUrl/transactions/getTransactionHistory');
      final user = localStorage.readUser;
      if (user == null) {
        return (
          <TransactionModel>[],
          ErrorModel(
            message: 'User not found',
          ),
        );
      }
      final headers = {
        'Authorization': 'Bearer ${user.token}',
      };
      final response = await client.get(
        uri,
        headers: headers,
      );
      logInfo(LoggerInfo(response.request, "getTransactionHistory request"));
      logInfo(LoggerInfo(headers, "getTransactionHistory request header "));
      if (response.statusCode == 200 || response.statusCode == 201) {
        logInfo(LoggerInfo(response, "getTransactionHistory response"));
        final data = json.decode(response.body);
        final transactions = (data['transactions'] as List)
            .map((transaction) => TransactionModel.fromJson(transaction))
            .toList();
        localStorage.writeTransactions(transactions);
        return (transactions, null);
      } else {
        logError(LoggerInfo(response, "getTransactionHistory response"));
        final e = ErrorModel.fromRawJson(response.body);
        if (e.message == "Token không hợp lệ") {
          localStorage.removeUser();
          localStorage.removeTransactions();
          navigator.currentContext!.pushAndRemoveUntil(RouteList.loginScreen);
          return (
            <TransactionModel>[],
            ErrorModel(
              message: 'Token không hợp lệ',
            ),
          );
        }
        return (
          <TransactionModel>[],
          e,
        );
      }
    } on Exception catch (e) {
      logError(LoggerInfo(e, "getTransactionHistory request"));
      return (
        <TransactionModel>[],
        ErrorModel(
          message: e.toString(),
        ),
      );
    }
  }

  Future<ErrorModel?> create(TransactionModel model) async {
    try {
      final uri = Uri.parse('$baseUrl/transactions/createTransaction');
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
        body: model.toJson(),
        headers: headers,
      );
      logInfo(LoggerInfo(response.request, "createTransaction request"));
      logInfo(LoggerInfo(model.toJson(), "createTransaction request body"));
      logInfo(LoggerInfo(headers, "createTransaction request header "));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //save
        logInfo(LoggerInfo(response, "createTransaction response"));
        return null;
      } else {
        logError(LoggerInfo(response, "createTransaction response"));
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
      logError(LoggerInfo(e, "createTransaction request"));
      return ErrorModel(
        message: e.toString(),
      );
    }
  }
}
