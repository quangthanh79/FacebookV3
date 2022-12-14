import 'package:facebook_auth/utils/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 03:56 - 21/10/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 * Class ProgressDialog has a function static excute during await task from internet
 */

class ProgressDialog {
  final BuildContext _context;
  ProgressDialog(this._context);

  bool _isOpen = false;

  //Su dung cai nay de goi function can show progress(function truyen vao phai la 1 async function)
  invokeFunctionWithDialog(Function function) async {
    _showAlertDialog();
    await function();
    if (_isOpen) {
      Navigator.of(_context).pop();
    }
  }

  // using 2 functions to show/hide progress
  showProgress() {
    if (!_isOpen) {
      _isOpen = true;
      _showAlertDialog();
    }
  }

  hideProgress() {
    if (_isOpen) {
      Navigator.of(_context).pop();
    }
  }

  _showAlertDialog() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    _isOpen = true;
    showDialog(
      barrierDismissible: false,
      context: _context,
      useRootNavigator: false, //this property needs to be added
      builder: (BuildContext context) {
        return Center(
            child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Lottie.asset(
                    'assets/animator_flutter.json',
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                )));
      },
    ).then((value) {
      _isOpen = false;
    });
  }
}
final progressDialog = ProgressDialog(navigatorKey.currentContext!);
