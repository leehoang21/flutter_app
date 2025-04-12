import 'package:equatable/equatable.dart';
import 'package:flutter_app/common/base_bloc.dart';
import 'package:flutter_app/common/contant.dart';
import 'package:flutter_app/common/extension.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/presentation/routes.dart';
part 'profile_state.dart';

class ProfileCubit extends BaseBloc<ProfileState> {
  ProfileCubit() : super(LoginInitial());

  @override
  onInit() {
    final user = serviceApp?.localStorage.readUser;
    if (user != null) {
      emit(state.copyWith(user: user.user));
    }
  }

  chagePass(String pass) async {
    final e = await serviceApp?.authService.changePassword(pass);
    if (e != null) {
      showSnackbar(e.toString());
    } else {
      await pop('');
      showSnackbar('Đổi mật khẩu thành công');
    }
  }

  chagePin(String pin) async {
    final e = await serviceApp?.authService.changePin(pin);
    if (e != null) {
      showSnackbar(e.toString());
    } else {
      await pop('');
      showSnackbar('Đổi mã PIN thành công');
    }
  }

  logout() async {
    await serviceApp?.localStorage.removeUser();
    await serviceApp?.localStorage.removeTransactions();
    pushAndRemoveUntil(RouteList.loginScreen);
  }
}
