

import 'package:equatable/equatable.dart';

abstract class PrepareSignUpEvent extends Equatable {
  const PrepareSignUpEvent();

  @override
  List<Object> get props => [];
}
class SignUpPhoneChanged extends PrepareSignUpEvent{
  const SignUpPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [this.phone];
}
class SignUpPasswordChanged extends PrepareSignUpEvent{
  const SignUpPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [this.password];
}