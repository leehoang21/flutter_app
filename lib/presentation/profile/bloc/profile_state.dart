part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User user;
  const ProfileState(this.user);

  ProfileState copyWith({
    User? user,
  }) {
    return ProfileState(
      user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}

final class LoginInitial extends ProfileState {
  LoginInitial() : super(User.empty());
}
