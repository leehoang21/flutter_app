import 'package:equatable/equatable.dart';
import 'package:flutter_app/common/base_bloc.dart';
import 'package:flutter_app/common/extension.dart';
import 'package:flutter_app/models/transaction_model.dart';

import '../../../common/contant.dart';
part 'create_transaction_state.dart';

class CreateTransactionCubit extends BaseBloc<CreateTransactionState> {
  CreateTransactionCubit() : super(CreateTransactionInitial());

  Future<void> create(
      String receiverAccount, String amount, String pincode) async {
    final a = num.tryParse(amount);
    if (a == null) {
      showSnackbar('Amount must be a number');
      return;
    }
    final model = TransactionModel(
        stkGui: '',
        stkNhan: receiverAccount,
        amount: a,
        pincode: pincode,
        thoiGianGiaoDich: '');
    final result = await serviceApp!.transactionService.create(model);
    if (result != null) {
      showSnackbar(result.message);
    } else {
      pop('');
    }
  }
}
