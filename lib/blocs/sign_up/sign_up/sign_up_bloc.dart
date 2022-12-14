

import 'dart:io';

import 'package:facebook_auth/blocs/sign_up/models/password.dart';
import 'package:facebook_auth/blocs/sign_up/sign_up/sign_up_event.dart';
import 'package:facebook_auth/blocs/sign_up/sign_up/sign_up_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/models/user_sign_up.dart';
import '../../../data/repository/authen_repository.dart';



class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
  final AuthenRepository _authenRepository;
  final String phone;
  final String password;
  SignUpBloc(this._authenRepository, this.phone,this.password): super(SignUpState()){
    _onSignUpSubmit();
  }


  Future<void> _onSignUpSubmit() async {
    await Future.delayed(Duration(seconds: 2));
    print("-----SIGN UP SUBMIT-----");
    print("1. Phone: " + phone);
    print("2. Password: " + password);
    try {
      ResponseSignUp? response = await _authenRepository.signUp(
          phone, password);
      if(response != null ){
        print("DANG KY THANH CONG");
        emit(state.copyWidth(statusSignUp: FormzStatus.submissionSuccess, verifyCode:  response.data!.verifyCode));
      } else {
        print("DANG KY THAT BAI");
        emit(state.copyWidth(statusSignUp: FormzStatus.submissionFailure));
      }
      print("SIGN UP BLOC response: "+ response.toString());
    } on SocketException catch (_) {

    }

  }
}