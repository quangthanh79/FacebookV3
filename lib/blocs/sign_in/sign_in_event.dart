

import 'package:equatable/equatable.dart';


/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 02:27 - 06/111/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 * Class SignInEvent using BLoC Architecture
 */

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInPhoneChanged extends SignInEvent {
  const SignInPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [this.phone];
}

class SignInPasswordChanged extends SignInEvent {
  const SignInPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [this.password];
}

class SignInSubmit extends SignInEvent {
  const SignInSubmit();


  @override
  List<Object> get props => [];
}