import 'package:flutter_app/presentation/main/view/main_contant.dart';
import 'package:flutter_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:flutter_app/presentation/transaction/bloc/transaction_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabMangerCubit extends Cubit<int> {
  TabMangerCubit() : super(0);

  void changePage(
      int index, TransactionCubit transactionCubit, ProfileCubit profileCubit) {
    for (var i in MainConstants.bottomIconsData.asMap().entries) {
      if (i.value['label'] == 'Transactions') {
        transactionCubit.onInit();
      } else if (i.value['label'] == 'My page') {
        profileCubit.onInit();
      }
    }
    emit(index);
  }
}
