

import 'dart:io';

import 'package:facebook_auth/data/datasource/remote/authen_api_provider.dart';
import 'package:facebook_auth/data/datasource/local/user_local_data.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';

import '../models/user_sign_in.dart';
import '../models/user_sign_up.dart';

class AuthenRepository {
  late UserLocalDataSource _userLocalDataSource;
  late AuthenApiProvider _apiAuthenProvider;

  Future<AuthenRepository> init() async {
    this._apiAuthenProvider = getIt.get<AuthenApiProvider>();
    this._userLocalDataSource = await getIt.getAsync<UserLocalDataSource>();
    return this;
  }

  Future<ResponseSignUp?> signUp(String phone, String password) => _apiAuthenProvider.signUp(phone, password);
  Future<ResponseSignIn?> signIn(String phone, String password) => _apiAuthenProvider.signIn(phone, password);
  Future<ResponseSignUp?> getVerifyCode(String phone) => _apiAuthenProvider.getVerifyCode(phone);
  Future<ResponseSignIn?> checkVerifyCode(String phone, String verifyCode) => _apiAuthenProvider.checkVerifyCode(phone, verifyCode);
  Future<ResponseUser?> changeInfoAfterSignup(String username, File? avatar) => _apiAuthenProvider.changeInfoAfterSignup(username, avatar);

  void registerToken(String tokenFCM) async {
    String? oldToken = await _userLocalDataSource.getUserNotificationToken();
    if (oldToken == tokenFCM) {
      return;
    } else {
      print("CHHUAN BI CALL API REGISTER");
      Optional response = await _apiAuthenProvider.registerToken(tokenFCM);
      print(response.toString());
      if (response == Optional.success) {
        _userLocalDataSource.setUserNotificationToken(tokenFCM);
      }
    }
  }
}