

import 'dart:async';

import 'package:facebook_auth/screen/login/validate.dart';
/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 03:37 - 21/10/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 * Class AuthenBloc using BLoC Architecture
 */

class AuthenBloc{
  StreamController _phoneController    = StreamController();
  StreamController _passwordController = StreamController();

  Stream get phoneStream    => _phoneController.stream;
  Stream get passwordStream => _passwordController.stream;
  bool isValidPhone(String phone){
    if(Validate.isValidPhone(phone) !=null){
      _phoneController.sink.addError(Validate.isValidPhone(phone)!);
      return false;
    }
    _phoneController.sink.add("OK");
    return true;
  }
  bool isValidPasword(String password){
    if(Validate.isValidPassword(password) !=null){
      _passwordController.sink.addError(Validate.isValidPassword(password)!);
      return false;
    }
    _passwordController.sink.add("OK");
    return true;
  }

}