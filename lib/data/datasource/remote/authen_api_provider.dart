import 'dart:convert';
import 'dart:io';

import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/session_user.dart';

import '../../models/user_sign_in.dart';
import '../../models/user_sign_up.dart';

class AuthenApiProvider extends BaseClient{
  Future<ResponseSignUp?> signUp(String phone, String password) async{
    var url = "auth/signup";
    final response = await post(
        url,
        {"phonenumber": phone,"password": password}
        );
    if (response != null) return ResponseSignUp.fromJson(response);
  }
  Future<ResponseSignIn?> signIn(String phone, String password) async{
    var url = "auth/login";
    final response = await post(
        url,
        {"phonenumber": phone,"password": password}
    );
    if (response != null) return ResponseSignIn.fromJson(response);
  }
  Future<Optional> registerToken(String tokenFCM) async {
    String? token = SessionUser.token;
    print("token: "+ (token ?? ""));
    var url = "auth/token_notification";
    try {
      final response = await post(
          url, {"tokenFCM": tokenFCM,"token":token});
      print("--------------------------");
      print(response);
      if (response != null) {
        return Optional.success;
      } else {
        return Optional.error;
      }
    } catch (e) {
      print("AuthenApiProvider:");
      print(e);
      return Optional.error;
    }
  }
  Future<ResponseSignUp?> getVerifyCode(String phone) async{
    var url = "auth/get_verify_code";
    final response = await post(
        url,
        {"phonenumber": phone}
    );
    if (response != null) return ResponseSignUp.fromJson(response);
  }
  Future<ResponseSignIn?> checkVerifyCode(String phone, String verifyCode) async{
    var url = "auth/check_verify_code";
    final response = await post(
        url,
        {"phonenumber": phone,"code_verify": verifyCode}
    );
    if (response != null) return ResponseSignIn.fromJson(response);
  }
  Future<ResponseUser?> changeInfoAfterSignup(String username, File? avatar) async {
    String url = "auth/change_info_after_signup";
    var files = <String, File>{};
    if (avatar != null) files['avatar'] = avatar;
    var response = await post_with_file(url, {"token": SessionUser.token, "username" : username}, files);
    if (response != null) return ResponseUser.fromJson(response);
    return null;
  }
}
