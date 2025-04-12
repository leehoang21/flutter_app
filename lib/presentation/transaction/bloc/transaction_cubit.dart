import 'package:equatable/equatable.dart';
import 'package:flutter_app/common/base_bloc.dart';
import 'package:flutter_app/common/extension.dart';

import '../../../common/contant.dart';
import '../../../models/transaction_model.dart';

part 'transaction_state.dart';

class TransactionCubit extends BaseBloc<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  @override
  onInit() {
    get();
  }

  Future<void> get() async {
    final result = await serviceApp!.transactionService.get();
    if (result.$2 != null) {
      showSnackbar(result.$2!.message);
    } else {
      emit(state.copyWith(
        transactions: result.$1,
      ));
    }
  }
}
