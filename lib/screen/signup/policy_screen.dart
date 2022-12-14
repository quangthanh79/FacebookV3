import 'dart:convert';

import 'package:facebook_auth/screen/signup/loading_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/Button.dart';
import '../../utils/widget/appbar_signup.dart';

class PolicyScreen extends StatefulWidget {
  @override
  PolicyScreenState createState() => PolicyScreenState();
}

class PolicyScreenState extends State<PolicyScreen> {
  // final _key = UniqueKey();
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    final phone = argument["phone"] as String;
    final password = argument["password"] as String;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            top: true,
            child: Center(
                child: Column(children: [
              getAppBar(context, "Điều khoản & quyển riêng tư"),
              SizedBox(height: 70),
              Container(
                height: 200,
                child: WebView(
                  initialUrl: 'about:blank',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                    _loadHtmlFromAssets();
                  },
                ),
              ),
              SizedBox(height: 90),
              Button.buildButtonPrimary(context, "Đăng ký", () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingSignUpScreen(),
                        settings: RouteSettings(
                            arguments: {"phone": phone, "password": password})),
                    (Route<dynamic> route) => false);
              })
            ]))));
  }

  _loadHtmlFromAssets() async {
    String fileText =
        await rootBundle.loadString('assets/webview/register_success.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
