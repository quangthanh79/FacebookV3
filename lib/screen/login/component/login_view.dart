
import 'package:facebook_auth/screen/login/component/password_input.dart';
import 'package:facebook_auth/screen/login/component/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../base/base_widgets.dart';
import '../../../blocs/sign_in/sign_in_bloc.dart';
import '../../../blocs/sign_in/sign_in_state.dart';
import '../../../utils/Progress_Dialog.dart';
import '../../../utils/app_theme.dart';
import '../../main_facebook.dart';
import '../../signup/splash_sign_up_screen.dart';
import 'button_sign_in.dart';

class LoginView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark ,
    ));

    return BlocListener<SignInBloc,SignInState>(
      listener: (context,state){
        switch(state.statusSignIn){
          case FormzStatus.submissionInProgress:
            progressDialog.showProgress();
            break;
          case FormzStatus.submissionSuccess:
            progressDialog.hideProgress();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainFacebookScreen(),
                ),
                    (Route<dynamic> route) => false
            );
            break;
          case FormzStatus.submissionFailure:
            progressDialog.hideProgress();
            const SnackBar snackBar = SnackBar(
              content: Text('Tài khoản hoặc mật khẩu không chính xác!'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showSnackBar(snackBar);
            break;
          case FormzStatus.submissionCanceled:
            progressDialog.hideProgress();
            break;
        }
      },
      child: SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                  resizeToAvoidBottomInset : false,
                  body: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        buildTopBackground(),
                        const SizedBox(
                          height: 40,
                        ),
                        PhoneInput(),
                        PasswordInput(),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonSignIn(),
                        buildForgotPassword(),
                        const SizedBox(
                          height: 22,
                        ),
                        buildDeliver(context),
                        buildButtonSignUp(context),
                      ],
                    ),
                  )
              )
          )
      ),
    );


  }
  Padding buildButtonSignUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: SizedBox(
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SplashSignUpScreen()));
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(4)))),
          color: AppTheme.buttonGreen,
          child: const Text(
            "Tạo tài khoản Facebook mới",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildTopBackground(){
    return Container(
      child: Image.asset("assets/images/top_background.jpg"),
    );
  }

  Padding buildDeliver(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          width: MediaQuery.of(context).size.width / 2 - 60,
          height: 1,
          color: AppTheme.greyDeliver,
        ),
        const Text(
          "HOẶC",
          style: TextStyle(color: AppTheme.greyText),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2 - 60,
          height: 1,
          color: AppTheme.greyDeliver,
        ),
      ]),
    );
  }

  Widget buildForgotPassword() {
    return buildTextPress("Quên mật khẩu?", AppTheme.primary,FontWeight.bold);
  }

}