


import 'dart:io';

import 'package:facebook_auth/base/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/json_utils.dart';
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

    var body = <String, File>{};
    if (user.avatar_file != null) body['avatar'] = user.avatar_file!;
    // print(user.avatar_file!.path);
    if (user.cover_image_file != null) body['cover_image'] = user.cover_image_file!;


    final response = await post_with_file(
        url,
        params.map((key, value) => MapEntry(key, value.toString())),
        body
    );
    if (response != null) return ResponseUser.fromJson(response);
    print("null rồi bạn ơi");
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

  @override
  Future<dynamic> post(String url, dynamic body) async{
    url = baseUrl + url;
    print("API post: $url "+ body.toString());

    final response = await http
        .post(
        Uri.parse(url).replace(queryParameters: body)
    ).timeout(const Duration(seconds: 30));
    print("BASE CLIENT: "+ response.body.toString());

    return jsonDecodeUtf8(response.bodyBytes);
  }
}
final userApiProvider = UserApiProvider();

