

import 'package:equatable/equatable.dart';
import 'package:facebook_auth/blocs/sign_up/models/password.dart';
import 'package:facebook_auth/blocs/sign_up/models/phone.dart';
import 'package:formz/formz.dart';

class PrepareSignUpState extends Equatable {
  final Phone phone;
  final Password password;


  const PrepareSignUpState({
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
  });

  PrepareSignUpState copyWidth({
    Phone? phone,
    Password? password,
  }){
    return PrepareSignUpState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [this.phone,this.password];

}