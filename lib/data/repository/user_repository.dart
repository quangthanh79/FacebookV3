

import 'package:facebook_auth/data/models/friend.dart';

import '../models/user_info.dart';
import '../datasource/remote/user_api_provider.dart';

class UserRepository {
  Future<bool> setUserInfor(User user) => userApiProvider.setUserInfor(user);

  Future<ResponseUser?> getUserInfor(String user_id) => userApiProvider.getUserInfor(user_id);
  Future<ResponseListFriend?> getUserFriends(String user_id, int page) => userApiProvider.getUserFriends(user_id,page);


}

