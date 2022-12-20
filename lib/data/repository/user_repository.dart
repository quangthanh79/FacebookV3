

import 'dart:io';

import 'package:facebook_auth/data/models/friend.dart';

import '../models/user_info.dart';
import '../datasource/remote/user_api_provider.dart';

class UserRepository {
  UserRepository();

  Future<ResponseUser?> setUserInfor(User user) => userApiProvider.setUserInfor(user);
  Future<ResponseUser?> getUserInfor(String user_id) => userApiProvider.getUserInfor(user_id);

}

