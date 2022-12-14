import 'package:facebook_auth/blocs/sign_in/sign_in_event.dart';
import 'package:facebook_auth/data/repository/authen_repository.dart';
import 'package:facebook_auth/screen/signup/splash_sign_up_screen.dart';
import 'package:facebook_auth/screen/splash/splash_screen.dart';
import 'package:facebook_auth/utils/Progress_Dialog.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../base/base_widgets.dart';

import '../../blocs/sign_in/models/password.dart';
import '../../blocs/sign_in/models/phone.dart';
import '../../blocs/sign_in/sign_in_bloc.dart';
import '../../blocs/sign_in/sign_in_state.dart';
import '../../icon/hide_icons.dart';
import '../../utils/app_theme.dart';
import '../../utils/context_ext.dart';
import '../main_facebook.dart';
import 'component/login_view.dart';

/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 23:22 - 25/10/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 * Class LoginScreen using BLoC Architecture
 */

class LoginScreen extends StatelessWidget {
  static Route<void> route() {
    return PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, _, __) {
          return new LoginScreen();
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            child: child,
            position: Tween<Offset>(
              begin: Offset(0.5, 0),
              end: Offset.zero,
            ).animate(animation),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    return BlocProvider(
        create: (context) => SignInBloc(getIt.get<AuthenRepository>()),
        child: LoginView());
  }

}
