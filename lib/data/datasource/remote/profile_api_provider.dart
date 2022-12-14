

import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/session_user.dart';

import '../../models/response_sign_out.dart';

class ProfileApiProvider extends BaseClient{
  Future<Optional> signOut() async{
    var url = "auth/logout";
    String? token = SessionUser.token;
    final response = await post(
      url,
      {"token": token}
    );

    if(response != null) return Optional.success;
    return Optional.error;
  }
}