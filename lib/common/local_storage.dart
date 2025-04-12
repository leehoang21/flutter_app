import 'package:flutter_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction_model.dart';

class LocalStorage {
  final SharedPreferencesWithCache _prefs;

  LocalStorage(this._prefs);

  writeUser(UserModel user) async {
    await _prefs.setString('user', user.toRawJson());
  }

  removeUser() async {
    await _prefs.remove('user');
  }

  UserModel? get readUser {
    final user = _prefs.getString('user');
    if (user != null) {
      return UserModel.fromRawJson(user);
    }
    return null;
  }

  writeTransactions(List<TransactionModel> transactions) async {
    final trans =
        transactions.map((transaction) => transaction.toJsonSave()).toList();
    await _prefs.setStringList('transactions', trans);
  }

  removeTransactions() async {
    await _prefs.remove('transactions');
  }

  List<TransactionModel> get readTransactions {
    final transactions = _prefs.getStringList('transactions');
    if (transactions != null) {
      return transactions
          .map((transaction) => TransactionModel.fromRawJson(transaction))
          .toList();
    }
    return <TransactionModel>[];
  }

  static Future<SharedPreferencesWithCache> get create {
    return SharedPreferencesWithCache.create(
        cacheOptions: SharedPreferencesWithCacheOptions(
            // This cache will only accept the key 'counter'.
            allowList: _allowList));
  }

  static get _allowList => <String>{'user', 'transactions'};
}
