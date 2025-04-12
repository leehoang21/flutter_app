import 'package:equatable/equatable.dart';
import 'package:flutter_app/common/base_bloc.dart';
import 'package:flutter_app/common/extension.dart';

import '../../../common/contant.dart';
import '../../routes.dart';

part 'login_state.dart';

class LoginCubit extends BaseBloc<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String name, String pass) async {
    final result = await serviceApp!.authService.signIn(name, pass);
    if (result.$2 != null) {
      showSnackbar(result.$2!.message);
    } else {
      pushAndRemoveUntil(RouteList.main);
    }
  }
}
