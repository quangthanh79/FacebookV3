import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/models/user_storage.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/datasource/local/flutter_secure_storage.dart';
import '../../data/models/user_sign_in.dart';
import '../../utils/session_user.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _authenticationRepository = getIt.get();

  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription = _tryGetUser().listen((event) {
      if(event){
        add(AuthenticationStatusChanged(
            AuthenticationStatus.authenticated));
      }else{
        add(AuthenticationStatusChanged(
            AuthenticationStatus.unauthenticated));
      }
    });
  }

  late StreamSubscription<bool> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        ResponseUser? response_user = await _authenticationRepository.getUserInfor("");
        if(response_user != null){
          SessionUser.user = response_user.data;
        }else{
          return emit(const AuthenticationState.unknown());
        }
        return emit(AuthenticationState.authenticated());
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }


  }

  Stream<bool> _tryGetUser() async* {
    try {
      await Future.delayed(Duration(seconds: 1));

      UserStorage? userStorage = await SecureStorage.instance.getUserData();
      // await storage.delete(key: "token");
      // await storage.delete(key: "idUser");

      SessionUser.token = userStorage?.token;
      SessionUser.idUser = userStorage?.idUser;

      /**
       * real flow
       */
      if (SessionUser.token != null) {
        yield true;
      } else {
        yield false;
      }
      /**
       * real flow
       */

    } catch (_) {
      yield false;
    }
  }
}
