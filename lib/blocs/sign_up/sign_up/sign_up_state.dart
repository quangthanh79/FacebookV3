

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/blocs/sign_up/models/password.dart';
import 'package:facebook_auth/blocs/sign_up/models/phone.dart';
import 'package:formz/formz.dart';

class SignUpState extends Equatable {
  final FormzStatus statusSignUp;
  final String verifyCode;

  const SignUpState({
    this.statusSignUp = FormzStatus.pure,
    this.verifyCode = ""
  });

  SignUpState copyWidth({
    FormzStatus? statusSignUp,
    String? verifyCode
  }){
    return SignUpState(
      statusSignUp: statusSignUp ?? this.statusSignUp,
      verifyCode: verifyCode ?? this.verifyCode
    );
  }

  @override
  List<Object?> get props => [this.statusSignUp, this.verifyCode];

}