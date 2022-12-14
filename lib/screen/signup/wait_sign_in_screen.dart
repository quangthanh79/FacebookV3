import 'package:facebook_auth/blocs/verify_code/verify_code_bloc.dart';
import 'package:facebook_auth/blocs/verify_code/verify_code_state.dart';
import 'package:facebook_auth/screen/signup/confirm_account_screen.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:facebook_auth/utils/widget/appbar_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../data/repository/authen_repository.dart';
import '../../utils/app_theme.dart';

class WaitSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    final phone = argument["phone"] as String;
    final verifyCode = argument["verifyCode"] as String;

    return BlocProvider(
      create: (context){
        return VerifyCodeBloc(getIt.get<AuthenRepository>(),phone,verifyCode);
      },
      child: BlocListener<VerifyCodeBloc,VerifyCodeState>(
        listener: (context,state)  {

          if(state.statusSlide.isPure){
            print("State statusCheckCode la Pure");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmAccountScreen(),
                  settings: RouteSettings(
                        arguments: {"phone": phone,"verifyCode" :verifyCode}
                    )
                ),
                    (Route<dynamic> route) => false
            );
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                top: true,
                child: Center(
                    child: Column(
                        children: [
                          getAppBar2(context,"Đang đăng nhập..."),
                          SizedBox(height: 250,),
                          CircularProgressIndicator(),
                          SizedBox(height: 30,),
                          Text(
                              "Đang đăng nhập...",
                              style: TextStyle(
                                color: AppTheme.grey800,
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,)
                          ),
                        ]
                    )
                )
            )
        ),
      )
    );
  }
}
