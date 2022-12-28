

part of 'change_info_after_signup_bloc.dart';

enum ChangeInfoAfterSignupStatus{
  INITIAL,
  WRONG_USERNAME, WRONG_AVATAR, OKAY,
  SENDING, SUCCESS, FAILED
}

// ignore: must_be_immutable
class ChangeInfoAfterSignupState extends Equatable{
  String? message;
  User? user;
  ChangeInfoAfterSignupStatus status;
  ChangeInfoAfterSignupState({
    required this.status,
    this.message,
    this.user
  });
  @override
  List<Object?> get props => [message, status, user, Random().nextInt(10000)];
}



