


import 'package:facebook_auth/base/base_client.dart';
import 'package:facebook_auth/data/models/friend.dart';
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/utils/session_user.dart';

class UserApiProvider extends BaseClient{
  // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODNhN2I3ZGE4YTViZGU4MzljNThjYyIsImRhdGVMb2dpbiI6IjIwMjItMTEtMzBUMTU6Mjg6MTQuMjQyWiIsImlhdCI6MTY2OTgyMjA5NCwiZXhwIjoxNjc5ODIyMDkzfQ.mac6fnO9WAreMl3_numHXMptxCsuP77bETtTYh4TARA";
  // String? token = SessionUser.token;

  Future<ResponseUser?> setUserInfor(User user) async {
    var url = "user/set_user_info";
    var params = {
      "token" : SessionUser.token
    };
    params.addAll(user.toJson());
    final response = await post(
        url, params.map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseUser.fromJson(response);
    return null;
  }

  Future<ResponseUser?> getUserInfor(String user_id) async {
    var url = "user/get_user_info";
    final response = await post(
        url,
        {"token": SessionUser.token,"user_id": user_id}
            .map((key, value) => MapEntry(key, value.toString()))
    );
    if (response != null) return ResponseUser.fromJson(response);
    return null;
  }

}
final userApiProvider = UserApiProvider();

