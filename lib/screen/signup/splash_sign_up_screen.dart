import 'package:facebook_auth/screen/signup/phone_sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/Button.dart';
import '../../utils/app_theme.dart';

class SplashSignUpScreen extends StatelessWidget {
  SplashSignUpScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
        builder: (context) => SplashSignUpScreen());
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Center(
            child: Column(
              children: [
                getAppBar(context),
                SizedBox(height: 55),
                Image.asset(
                    "assets/images/logo_signup.png",
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 2 / 3),
                SizedBox(height: 60),
                const Text(
                    "Tham gia Facebook",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Chúng tôi sẽ giúp bạn tạo tài khoản mới sau vài bước dễ dàng.",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.normal,
                        color: AppTheme.grey800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 60),
                Button.buildButtonPrimary(context,"Tiếp",() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PhoneSignUpScreen()));
                }),
                Expanded(child: SizedBox()),
                MaterialButton(
                  onPressed: () {},
                  child: const Text(
                      "Bạn đã có tài khoản ư?",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary)),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget getAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.grey500),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            splashRadius: 20,
            icon: Icon(Icons.arrow_back, size: 22,),
          ),
          Text("Tạo tài khoản", style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }

}