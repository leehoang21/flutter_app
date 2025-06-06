import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<T> extends Cubit<T> {
  BaseBloc(super.initialState) {
    onInit();
  }

  dynamic onInit() {}
}
