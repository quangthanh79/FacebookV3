import 'package:facebook_auth/blocs/sign_up/models/phone.dart';
import 'package:facebook_auth/blocs/sign_up/prepare_sign_up/prepare_sign_up_bloc.dart';
import 'package:facebook_auth/screen/signup/password_sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/sign_up/prepare_sign_up/prepare_sign_up_event.dart';
import '../../blocs/sign_up/prepare_sign_up/prepare_sign_up_state.dart';
import '../../utils/Button.dart';
import '../../utils/app_theme.dart';
import '../../utils/widget/appbar_signup.dart';

class PhoneSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    return BlocProvider(
        create: (context){
          return PrepareSignUpBloc();
        },
        child: BlocBuilder<PrepareSignUpBloc,PrepareSignUpState>(
          builder: (context,state){

            String? errorText;
            if (state.phone.invalid) {
              switch (state.phone.error) {
                case null:
                  errorText = null;
                  break;
                case PhoneValidationError.empty:
                  errorText = "Vui lòng nhập số di động";
                  break;
                case PhoneValidationError.wrongFormat:
                  errorText = "Số di động sai định dạng";
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
                        getAppBar(context,"Số di động"),
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
                            "Nhập số di động để liên hệ của bạn. Bạn có thể ấn thông tin này trên trang cá nhân sau.",
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
                                      labelText: "Số di động",
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          print("OK");
                                        },
                                      ),
                                    errorText: errorText
                                  ),
                                  onChanged: (text){
                                    context.read<PrepareSignUpBloc>().add(SignUpPhoneChanged(text));
                                  },
                                ),
                              ),
                            )),
                        SizedBox(height: 80),
                        Button.buildButtonPrimary(context,"Tiếp",
                            state.phone.valid ?
                                () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PasswordSignUpScreen(),
                                          settings: RouteSettings(
                                            arguments: state.phone.value
                                          )
                                      )
                                  );
                                } : null
                        )
                      ],
                    ),
                  ),
                ));
          }
        )
    );
  }

}
