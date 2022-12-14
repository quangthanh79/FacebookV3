import 'package:facebook_auth/blocs/sign_up/prepare_sign_up/prepare_sign_up_bloc.dart';
import 'package:facebook_auth/screen/signup/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/sign_up/models/password.dart';
import '../../blocs/sign_up/prepare_sign_up/prepare_sign_up_event.dart';
import '../../blocs/sign_up/prepare_sign_up/prepare_sign_up_state.dart';
import '../../data/repository/authen_repository.dart';
import '../../utils/Button.dart';
import '../../utils/app_theme.dart';
import '../../utils/injection.dart';
import '../../utils/widget/appbar_signup.dart';

class PasswordSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    final phone = ModalRoute.of(context)!.settings.arguments as String;


    return BlocProvider(
        create: (context){
          return PrepareSignUpBloc();
        },
        child: BlocBuilder<PrepareSignUpBloc,PrepareSignUpState>(
          builder: (context,state){
            String? errorText;
            context.read<PrepareSignUpBloc>().add(SignUpPhoneChanged(phone));
            if (state.password.invalid) {
              switch (state.password.error) {
                case null:
                  errorText = null;
                  break;
                case PasswordValidationError.empty:
                  errorText = "Vui lòng nhập số di động";
                  break;
                case PasswordValidationError.inValidLength:
                  errorText = "Mật khẩu dài tối thiểu 6 ký tự";
                  break;
              }
            } else {
              errorText = null;
            }
            return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  top: true,
                  child: Center(
                    child: Column(
                      children: [
                        getAppBar(context,"Mật khẩu"),
                        SizedBox(height: 95),
                        const Text("Nhập số di động của bạn",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: Text(
                            "Tạo mật khẩu dài tối thiểu 6 ký tự. Đó phải là mật khẩu mà người khác không thể đoán được.",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.normal,
                                color: AppTheme.grey800),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 25),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              child: Container(
                                child:  TextField(
                                  autofocus: true,
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  decoration: InputDecoration(
                                      labelText: "Mật khẩu",
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          print("OK");
                                        },
                                      ),
                                    errorText: errorText
                                  ),
                                  onChanged: (text){
                                    context.read<PrepareSignUpBloc>().add(SignUpPasswordChanged(text));
                                  },
                                ),
                              ),
                            )),
                        SizedBox(height: 80),
                        Button.buildButtonPrimary(
                            context,
                            "Tiếp",
                             state.password.valid?
                                 () { Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PolicyScreen(),
                                          settings: RouteSettings(
                                            arguments: {"phone": state.phone.value, "password":state.password.value}
                                          )
                                        )
                                     );
                                    }: null
                        )
                      ],
                    ),
                  ),
                ));
          },
        )

    );
  }
}
