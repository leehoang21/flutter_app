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
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final transactions = (data['transactions'] as List)
            .map((transaction) => TransactionModel.fromJson(transaction))
            .toList();
        localStorage.writeTransactions(transactions);
        return (transactions, null);
      } else {
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
        logError(response.body);
        return (
          <TransactionModel>[],
          e,
        );
      }
    } on Exception catch (e) {
      logError(e);
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
