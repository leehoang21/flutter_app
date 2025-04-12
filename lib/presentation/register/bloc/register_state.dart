part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
}

final class LoginInitial extends RegisterState {
  @override
  List<Object> get props => [];
}
