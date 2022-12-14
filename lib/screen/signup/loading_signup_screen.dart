

import 'package:facebook_auth/blocs/sign_up/sign_up/sign_up_state.dart';
import 'package:facebook_auth/data/repository/authen_repository.dart';
import 'package:facebook_auth/screen/signup/error_sign_up_screen.dart';
import 'package:facebook_auth/screen/signup/wait_sign_in_screen.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../blocs/sign_up/sign_up/sign_up_bloc.dart';
import '../../icon/like_icons.dart';

import '../../utils/widget/appbar_signup.dart';

class LoadingSignUpScreen extends StatefulWidget {


  @override
  LoadingSignUpScreenState createState() => LoadingSignUpScreenState();

}
class LoadingSignUpScreenState extends State<LoadingSignUpScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    late final AnimationController _controllerIcon = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    late final AnimationController _controllerSlide = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    late final Animation<double> _animation = CurvedAnimation(
      parent: _controllerIcon,
      curve: Curves.ease,
    );

    final _firstSlide = Tween<Offset>(begin: Offset(0, 0), end: Offset(-1.0, 0))
        .animate(CurvedAnimation(
      parent: _controllerSlide,
      curve: Curves.fastOutSlowIn,
    ));

    final _secondSlide = Tween<Offset>(begin: Offset(1.0, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: _controllerSlide,
      curve: Curves.fastOutSlowIn,
    ));
    Tween<double> _tween = Tween(begin: 0.7, end: 1);

    // get argument from policy screen
    final argument = ModalRoute.of(context)!.settings.arguments  as Map;
    final phone = argument["phone"] as String;
    final password = argument["password"] as String;

    return BlocProvider(
      create: (context){
        return SignUpBloc(getIt.get<AuthenRepository>(),phone,password);
      },
      child: BlocListener<SignUpBloc,SignUpState>(
        listener: (context,state) async {
          if(state.statusSignUp.isPure){
            _controllerSlide.animateTo(0.0);
          }
          if(state.statusSignUp.isSubmissionSuccess){
            _controllerSlide.animateTo(1.0);
            print("Submission SUCCESS");
            await Future.delayed(Duration(milliseconds: 2000));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => WaitSignInScreen(),
                    settings: RouteSettings(
                        arguments: {"phone": phone,"verifyCode" :state.verifyCode}
                    )
                ),
                    (Route<dynamic> route) => false
            );

          }
          if(state.statusSignUp.isSubmissionFailure){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => ErrorSignUpScreen(),
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
                    children:  [
                      getAppBar(context,"Tạo tài khoản"),
                      Stack(
                        children: [
                          SlideTransition(
                            position: _firstSlide,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(height: 250,),
                                  CircularProgressIndicator(),
                                  SizedBox(height: 30,),
                                  Text(
                                      "Đang tạo tài khoản...",
                                      style: TextStyle(
                                        color: AppTheme.grey800,
                                        fontFamily: 'OpenSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SlideTransition(
                              position: _secondSlide,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 250,),
                                    ScaleTransition(
                                      scale: _tween.animate(_animation),
                                      child: const Icon(
                                        Like.like,
                                        color: AppTheme.primary,
                                        size: 60,),
                                    )
                                  ],
                                ),
                              )
                          ),
                        ],
                      ),

                    ],
                  ),
                )
            )
        )
      )
    );
  }

}