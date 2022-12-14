
import 'package:equatable/equatable.dart';
import 'package:facebook_auth/blocs/sign_in/models/password.dart';
import 'package:facebook_auth/blocs/sign_in/models/phone.dart';
import 'package:formz/formz.dart';


/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 02:28 - 06/111/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 * Class SignInState using BLoC Architecture
 */


class SignInState extends Equatable{
  final FormzStatus status;
  final Phone phone;
  final Password password;
  final FormzStatus statusSignIn;


  const SignInState({
    this.status = FormzStatus.pure,
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.statusSignIn = FormzStatus.pure
  });


  SignInState copyWith(
      { FormzStatus? status,
        Phone? phone,
        Password? password,
        FormzStatus? statusSignIn
      }) {
    return SignInState(
        status: status ?? this.status,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        statusSignIn: statusSignIn ?? FormzStatus.pure
    );
  }

  @override
  List<Object?> get props => [this.status,this.phone,this.password,this.statusSignIn];


}