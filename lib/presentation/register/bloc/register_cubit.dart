import 'package:equatable/equatable.dart';
import 'package:flutter_app/common/contant.dart';
import 'package:flutter_app/common/extension.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/presentation/routes.dart';
import '../../../common/base_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends BaseBloc<RegisterState> {
  RegisterCubit() : super(LoginInitial());

  Future<void> register(String name, String hoten, String stk, String pass,
      String pincode) async {
    final user = User(
        userName: name, password: pass, stk: stk, hoTen: hoten, code: pincode);
    final result = await serviceApp!.authService.signUp(user);
    if (result.$2 != null) {
      showSnackbar(result.$2!.message);
    } else {
      pushAndRemoveUntil(RouteList.main);
    }
  }
}
