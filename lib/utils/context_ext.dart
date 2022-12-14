import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

extension BuildContextX on BuildContext {
  void showNetworkError() {
    showDialog(
        context: this,
        useRootNavigator: false, //this property needs to be added
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 12, left: 24, right: 24),
            contentPadding: EdgeInsets.only(top: 12, left: 24, right: 24),
            //hard code
            title: Text("Đăng nhập không thành công"),
            insetPadding: EdgeInsets.symmetric(horizontal: 30),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Rất tiếc là không thể đăng nhập. Vui lòng kiểm tra kết nối internet.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(this).pop();
                  },
                  child: Text("OK"))
            ],

          );
        });
  }
  void showVerifyCode( String verifyCode) {
    showDialog(
        context: this,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 12, left: 24, right: 24),
            contentPadding: EdgeInsets.only(top: 12, left: 24, right: 24),
            //hard code
            title: Text("Mã xác thực"),
            insetPadding: EdgeInsets.symmetric(horizontal: 30),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Mã xác thực của bạn là: " + verifyCode,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],

          );
        });
  }
}