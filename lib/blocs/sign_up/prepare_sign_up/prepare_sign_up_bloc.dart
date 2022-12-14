

import 'dart:io';

import 'package:facebook_auth/blocs/sign_up/models/password.dart';
import 'package:facebook_auth/blocs/sign_up/prepare_sign_up/prepare_sign_up_event.dart';
import 'package:facebook_auth/blocs/sign_up/prepare_sign_up/prepare_sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../models/phone.dart';


class PrepareSignUpBloc extends Bloc<PrepareSignUpEvent,PrepareSignUpState>{
  PrepareSignUpBloc(): super(PrepareSignUpState()){
    on<SignUpPhoneChanged>(_onPhoneChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
  }
  void _onPhoneChanged(
      SignUpPhoneChanged event,
      Emitter<PrepareSignUpState> emit
      ){
    final phone = Phone.dirty(event.phone);
    emit(state.copyWidth(phone:phone));
  }
  void _onPasswordChanged(
      SignUpPasswordChanged event,
      Emitter<PrepareSignUpState> emit
      ){
    final password = Password.dirty(event.password);
    emit(state.copyWidth(password: password));
  }
}