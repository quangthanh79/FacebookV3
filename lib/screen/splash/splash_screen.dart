import 'package:facebook_auth/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: true,
          child: Container(
            child: Center(
              child: Column(
                children: [
                  Expanded(child: SizedBox(), flex: 6),
                  Expanded(
                    child: Image.asset(
                        "assets/images/facebook_splash.png",
                        width: 70,
                    ),
                    flex: 3),
                  Expanded(
                    child: Lottie.asset(
                        'assets/anima_splash.json',
                        width: 80,
                    ),
                    flex: 2),
                  Expanded(child: SizedBox(), flex: 4),
                  Text(
                      "from",
                      style: TextStyle(color: AppTheme.greyBlueText, fontSize: 16),
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Image.asset("assets/images/meta.png", height: 20),
                              SizedBox(width: 3)
                            ],
                          ),
                          flex: 9,
                          ),
                      Expanded(
                        child: Text("Meta",
                          style:
                            TextStyle(color: AppTheme.primary, fontSize: 18)),
                          flex: 10,
                      )
                      ],
                  ),
                  SizedBox(
                      height: 15,
                  )
                ],
            ),
          ),
        color: Colors.white,
      ),
    ));
  }
}
