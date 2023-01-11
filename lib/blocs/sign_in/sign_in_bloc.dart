import 'dart:io';

import 'package:facebook_auth/blocs/sign_in/models/password.dart';
import 'package:facebook_auth/blocs/sign_in/models/phone.dart';
import 'package:facebook_auth/blocs/sign_in/sign_in_event.dart';
import 'package:facebook_auth/blocs/sign_in/sign_in_state.dart';
import 'package:facebook_auth/data/datasource/local/flutter_secure_storage.dart';
import 'package:facebook_auth/data/models/user_info.dart' as UserInfor;
import 'package:facebook_auth/data/models/user_storage.dart';
import 'package:facebook_auth/data/repository/authen_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formz/formz.dart';

import '../../data/models/user_sign_in.dart';
import '../../utils/context_ext.dart';
import '../../utils/session_user.dart';



/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 02:26 - 06/111/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 * Class SignInBloc using BLoC Architecture
 */

class SignInBloc extends Bloc<SignInEvent,SignInState>{
  final AuthenRepository _authenRepository;
  SignInBloc(this._authenRepository): super(SignInState()){
    on<SignInPhoneChanged>(_onPhoneChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmit>(_onSubmitted);
  }

  void _onPhoneChanged(
      SignInPhoneChanged event,
      Emitter<SignInState> emit,
      ) {
    final phone = Phone.dirty(event.phone);
    emit( state.copyWith(
      phone: phone,
      status: Formz.validate([phone, state.password]),
    ));
  }

  void _onPasswordChanged(
      SignInPasswordChanged event,
      Emitter<SignInState> emit,
      ) {
    final password = Password.dirty(event.password);
    emit( state.copyWith(
      password: password,
      status: Formz.validate([state.phone, password]),
    ));
  }
  Future<void> _onSubmitted(
      SignInSubmit event,
      Emitter<SignInState> emit,
      ) async{
    try {
      emit( state.copyWith(statusSignIn: FormzStatus.submissionInProgress));
      ResponseSignIn? response = await _authenRepository.signIn(
          state.phone.value, state.password.value);
      if(response!= null){
        String token = response.data!.token!;
        String idUser = response.data!.id!;
        SecureStorage.instance.setUserData(UserStorage(token: token, idUser: idUser));

        SessionUser.token = token;
        SessionUser.idUser = idUser;

        UserRepository userRepository = UserRepository();
        UserInfor.ResponseUser? responseUser = await userRepository.getUserInfor(idUser);
        if (responseUser != null && responseUser.code == "1000"){
          SessionUser.user = UserInfor.User();
          SessionUser.user!.copyFrom(responseUser.data!);
        }

        emit( state.copyWith(statusSignIn: FormzStatus.submissionSuccess));
      }else{
        emit( state.copyWith(statusSignIn: FormzStatus.submissionFailure));
      }
    }on SocketException catch (_){
      await Future.delayed(Duration(milliseconds: 200));
      emit( state.copyWith(statusSignIn: FormzStatus.submissionCanceled));
      await Future.delayed(Duration(milliseconds: 200));
      navigatorKey.currentContext!.showNetworkError();
    }
  }
}