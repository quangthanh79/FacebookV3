
import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../../utils/widget/appbar_signup.dart';

class ErrorSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            top: true,
            child: Center(
                child: Column(
                    children: [
                      getAppBar2(context,"Lỗi đăng nhập..."),
                      SizedBox(height: 300,),
                      Text(
                          "Chúng tôi không thể đăng ký với tài khoản này.",
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
    );
  }

}